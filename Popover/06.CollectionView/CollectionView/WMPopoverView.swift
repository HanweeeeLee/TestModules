//
//  WMPopoverView.swift
//  CollectionView
//
//  Created by Aaron Hanwe LEE on 2023/05/04.
//  Copyright © 2023 hanwe lee. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Spring

@objc protocol WMPopoverContainerViewDelegate: AnyObject {
  @objc optional func tappedFunction(rawValue: Int)
  @objc optional func tappedEmoji(emoji: String)
}

final class WMPopoverContainerView: UIView, WMPopoverViewDelegate {
  
  enum WMPopoverEmoji: Int, Equatable, CaseIterable {
    case heart = 0
    case happy
    case sad
    case good
    case bad
    case fire
    
    var emoji: String {
      switch self {
      case .heart:
        return "❤️"
      case .happy:
        return "☺️"
      case .sad:
        return "😢"
      case .good:
        return "👍"
      case .bad:
        return "👎"
      case .fire:
        return "🔥"
      }
    }
    
    static func fromRawValue(_ rawValue: Int) -> WMPopoverEmoji? {
      for item in self.allCases where item.rawValue == rawValue {
        return item
      }
      return nil
    }
    
  }
  
  struct WMPopoverItem: Equatable {
    let rawValue: Int
    let name: String
    let nameFont: UIFont
    let nameTextColor: UIColor
    let backgroundColor: UIColor
    let highlightColor: UIColor
    let icon: UIImage?
    let iconColor: UIColor
  }
  
  // MARK: - components
  
  private lazy var baseView = UIView().then {
    $0.backgroundColor = .clear
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.baseViewTapAction(_:)))
    $0.addGestureRecognizer(tapGesture)
  }
  
  private let popoverView: WMPopoverView
  
  
  // MARK: - private properties
  
  private let popoverViewWidth: CGFloat = 214
  
  // MARK: - internal properties
  
  private(set) var isActive: Bool = false
  weak var delegate: WMPopoverContainerViewDelegate?
  
  // MARK: - life cycle
  
  init(itemList: [WMPopoverItem]) {
    self.popoverView = WMPopoverView(itemList: itemList)
    super.init(frame: .zero)
    self.popoverView.delegate = self
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - private method
  
  private func setup() {
    
    self.baseView.setSnpLayout(baseView: self, layoutConstraint: {
      $0.edges.equalToSuperview()
    })
    
    self.popoverView.setSnpLayout(baseView: self.baseView, layoutConstraint: {
      $0.width.equalTo(self.popoverViewWidth)
      $0.height.equalTo(popoverView.contentsHeight)
      $0.top.leading.equalToSuperview()
    })
    
    self.isHidden = true 
  }
  
  @objc func baseViewTapAction(_ recognizer: UITapGestureRecognizer) {
    inactive()
  }
  
  // MARK: - internal method
  
  func active(parentsView: UIView) {
    self.isActive = true
    self.isHidden = false
    let yOffset = parentsView.convert(CGPoint.zero, to: self).y
    if self.bounds.height > yOffset + popoverView.contentsHeight {
      self.popoverView.refreshUI(isUpperMode: false)
      self.popoverView.setSnpLayout(baseView: self.baseView, snpType: .remake, layoutConstraint: {
        $0.leading.equalTo(parentsView)
        $0.top.lessThanOrEqualTo(parentsView.snp.bottom)
        $0.width.equalTo(self.popoverViewWidth)
        $0.height.equalTo(self.popoverView.contentsHeight)
        $0.bottom.lessThanOrEqualToSuperview()
      })
    } else {
      self.popoverView.refreshUI(isUpperMode: true)
      self.popoverView.setSnpLayout(baseView: self.baseView, snpType: .remake, layoutConstraint: {
        $0.leading.equalTo(parentsView)
        $0.bottom.greaterThanOrEqualTo(parentsView.snp.top)
        $0.width.equalTo(self.popoverViewWidth)
        $0.height.equalTo(self.popoverView.contentsHeight)
        $0.top.greaterThanOrEqualToSuperview()
      })
    }
    self.popoverView.setAnimation(.zoomIn)
    self.popoverView.force = 0.1
    self.popoverView.velocity = 20
    self.popoverView.damping = 20
    self.popoverView.animate()
  }
  
  func inactive() {
    self.isActive = false
    self.isHidden = true
  }
  
  func tappedFunction(infoData: WMPopoverItem) {
    self.delegate?.tappedFunction?(rawValue: infoData.rawValue)
  }
  
  func selecteEmoji(emoji: WMPopoverEmoji) {
    self.delegate?.tappedEmoji?(emoji: emoji.emoji)
  }
  
}

fileprivate protocol WMPopoverViewDelegate: WMPopoverfunctionContainerViewDelegate, WMPopoverEmojiContainerViewDelegate { }

fileprivate final class WMPopoverView: SpringView, WMPopoverfunctionContainerViewDelegate, WMPopoverEmojiContainerViewDelegate {
  
  // MARK: - components
  
  private let baseView = UIView().then {
    $0.backgroundColor = .clear
  }
  
  // MARK: - private properties
  
  private let functionView: WMPopoverfunctionContainerView
  private let emojiView: WMPopoverEmojiContainerView
  private let sectionInset: CGFloat = 4
  
  // MARK: - internal properties
  
  var contentsHeight: CGFloat {
    return self.functionView.contentsHeight + self.emojiView.height + self.sectionInset
  }
  
  weak var delegate: WMPopoverViewDelegate?
  
  // MARK: - life cycle
  
  init(itemList: [WMPopoverContainerView.WMPopoverItem]) {
    self.functionView = WMPopoverfunctionContainerView(itemList: itemList)
    self.emojiView = WMPopoverEmojiContainerView(backgroundColor: itemList.count > 0 ? itemList[0].backgroundColor : .white)
    super.init(frame: .zero)
    self.functionView.delegate = self
    self.emojiView.delegate = self
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - private method
  
  private func setup() {
    
    self.baseView.setSnpLayout(baseView: self, layoutConstraint: {
      $0.edges.equalToSuperview()
    })
    
    self.emojiView.setSnpLayout(baseView: self.baseView, layoutConstraint: {
      $0.leading.top.equalToSuperview()
      $0.trailing.lessThanOrEqualToSuperview()
    })
    
    self.functionView.setSnpLayout(baseView: self.baseView, layoutConstraint: {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.top.equalTo(self.emojiView.snp.bottom).offset(self.sectionInset)
    })
    
  }
  
  // MARK: - internal method
  
  func tappedFunction(infoData: WMPopoverContainerView.WMPopoverItem) {
    self.delegate?.tappedFunction(infoData: infoData)
  }
  
  func selecteEmoji(emoji: WMPopoverContainerView.WMPopoverEmoji) {
    self.delegate?.selecteEmoji(emoji: emoji)
  }
  
  func refreshUI(isUpperMode: Bool) {
    if isUpperMode {
      self.functionView.snp.remakeConstraints {
        $0.leading.trailing.top.equalToSuperview()
      }
      self.emojiView.snp.remakeConstraints {
        $0.leading.bottom.equalToSuperview()
        $0.trailing.lessThanOrEqualToSuperview()
        $0.top.equalTo(self.functionView.snp.bottom).offset(self.sectionInset)
      }
    } else {
      self.emojiView.snp.remakeConstraints {
        $0.leading.top.equalToSuperview()
        $0.trailing.lessThanOrEqualToSuperview()
      }
      self.functionView.snp.remakeConstraints {
        $0.leading.trailing.bottom.equalToSuperview()
        $0.top.equalTo(self.emojiView.snp.bottom).offset(self.sectionInset)
      }
    }
  }
  
}

fileprivate protocol WMPopoverEmojiContainerViewDelegate: AnyObject {
  func selecteEmoji(emoji: WMPopoverContainerView.WMPopoverEmoji)
}

fileprivate final class WMPopoverEmojiContainerView: UIView {

  // MARK: - components

  private lazy var baseView = UIView().then {
    $0.backgroundColor = self.backgroundColorValue
    $0.layer.cornerRadius = 16
    $0.layer.shadowOpacity = 1
    $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    $0.layer.shadowRadius = 24
    $0.layer.shadowColor = UIColor(red: 0.063, green: 0.078, blue: 0.212, alpha: 0.16).cgColor
    $0.layer.masksToBounds = false
  }
  
  private let emojiStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fill
  }

  // MARK: - private properties
  
  private let emojiList: [WMPopoverContainerView.WMPopoverEmoji] = WMPopoverContainerView.WMPopoverEmoji.allCases
  private let backgroundColorValue: UIColor
  private let emojiItemWidth: CGFloat = 32
  private let listLeftRightInset: CGFloat = 6
  private let itemInset: CGFloat = 2

  // MARK: - internal properties
  let height: CGFloat = 32
  var width: CGFloat {
    return (CGFloat(self.emojiList.count) * self.emojiItemWidth) + (CGFloat(self.emojiList.count - 1) * self.itemInset) + (2 * self.listLeftRightInset)
  }
  
  weak var delegate: WMPopoverEmojiContainerViewDelegate?

  // MARK: - life cycle

  init(backgroundColor: UIColor) {
    self.backgroundColorValue = backgroundColor
    super.init(frame: .zero)
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - private method
  
  private func setup() {
    
    self.baseView.setSnpLayout(baseView: self, layoutConstraint: {
      $0.edges.equalToSuperview()
      $0.width.equalTo(self.width)
      $0.height.equalTo(self.height)
    })
    
    self.emojiStackView.setSnpLayout(baseView: self.baseView, layoutConstraint: {
      $0.trailing.leading.equalToSuperview().inset(self.listLeftRightInset)
      $0.top.bottom.equalToSuperview()
    })
    
    for emoji in self.emojiList {
      let emojiView = UIButton()
      emojiView.setTitle(emoji.emoji, for: .normal)
      emojiView.setTitle(emoji.emoji, for: .highlighted)
      emojiView.setTitle(emoji.emoji, for: .disabled)
      emojiView.setTitle(emoji.emoji, for: .focused)
      emojiView.snp.makeConstraints {
        $0.width.equalTo(self.emojiItemWidth)
        $0.height.equalTo(self.height)
      }
      emojiView.tag = emoji.rawValue
      emojiView.addTarget(self, action: #selector(selectedEmoji), for: .touchUpInside)
      self.emojiStackView.addArrangedSubview(emojiView)
      
      if emoji != self.emojiList.last {
        let insetView = UIView().then {
          $0.backgroundColor = .clear
        }
        insetView.snp.makeConstraints {
          $0.width.equalTo(self.itemInset)
          $0.height.equalTo(self.height)
        }
        self.emojiStackView.addArrangedSubview(insetView)
      }
    }
    
  }
  
  @objc private func selectedEmoji(sender: UIButton!) {
    let emojiRawValue = sender.tag
    guard let emoji = WMPopoverContainerView.WMPopoverEmoji.fromRawValue(emojiRawValue) else { return }
    self.delegate?.selecteEmoji(emoji: emoji)
  }

  // MARK: - internal method

}

fileprivate protocol WMPopoverfunctionContainerViewDelegate: AnyObject {
  func tappedFunction(infoData: WMPopoverContainerView.WMPopoverItem)
}

fileprivate final class WMPopoverfunctionContainerView: UIView, WMPopoverfunctionContainerViewDelegate {
  
  // MARK: - components
  
  private let baseContainerView = UIView().then {
    $0.backgroundColor = .clear
    $0.layer.cornerRadius = 20
    $0.layer.shadowOpacity = 1
    $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    $0.layer.shadowRadius = 24
    $0.layer.shadowColor = UIColor(red: 0.063, green: 0.078, blue: 0.212, alpha: 0.16).cgColor
    $0.layer.masksToBounds = false
  }
  
  private let baseView = UIView().then {
    $0.backgroundColor = .clear
    $0.layer.cornerRadius = 20
    $0.layer.masksToBounds = true
  }
  
  private let functionStackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .fill
  }
  
  // MARK: - private properties
  
  private let itemList: [WMPopoverContainerView.WMPopoverItem]
  private let functionCellItemHeight: CGFloat = 42
  private let lineHeight: CGFloat = 1
  private let lineColor: UIColor = .gray
  
  // MARK: - internal properties
  
  var contentsHeight: CGFloat {
    return (CGFloat(itemList.count) * functionCellItemHeight) + (CGFloat(itemList.count - 1) * lineHeight)
  }
  
  weak var delegate: WMPopoverfunctionContainerViewDelegate?
  
  // MARK: - life cycle
  
  init(itemList: [WMPopoverContainerView.WMPopoverItem]) {
    self.itemList = itemList
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - private method
  private func setup() {
    
    self.baseContainerView.setSnpLayout(baseView: self, layoutConstraint: {
      $0.edges.equalToSuperview()
    })
    
    self.baseView.setSnpLayout(baseView: self.baseContainerView, layoutConstraint: {
      $0.edges.equalToSuperview()
    })
    
    self.functionStackView.setSnpLayout(baseView: self.baseView, layoutConstraint: {
      $0.edges.equalToSuperview()
    })
    
    for item in itemList {
      let cell = WMPopoverfunctionItemView(infoData: item)
      cell.delegate = self
      cell.snp.makeConstraints {
        $0.height.equalTo(self.functionCellItemHeight)
      }
      self.functionStackView.addArrangedSubview(cell)
      if itemList.last != item {
        let lineView = UIView().then {
          $0.backgroundColor = self.lineColor
        }
        lineView.snp.makeConstraints {
          $0.height.equalTo(1)
        }
        self.functionStackView.addArrangedSubview(lineView)
      }
    }
    
  }
  
  // MARK: - internal method
  
  func tappedFunction(infoData: WMPopoverContainerView.WMPopoverItem) {
    self.delegate?.tappedFunction(infoData: infoData)
  }
  
}

fileprivate final class WMPopoverfunctionItemView: UIView {
  
  // MARK: - components
  
  private lazy var baseView = UIView().then {
    $0.backgroundColor = self.defaultBackgroundColor
  }
  
  private lazy var titleLabel = UILabel().then {
    $0.font = self.infoData.nameFont
    $0.textColor = self.infoData.nameTextColor
    $0.text = self.infoData.name
  }
  
  private lazy var button = UIButton().then {
    $0.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    $0.addTarget(self, action: #selector(touchDown), for: .touchDown)
    $0.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
    $0.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
  }
  
  // MARK: - private properties
  
  private let infoData: WMPopoverContainerView.WMPopoverItem
  
  private lazy var defaultBackgroundColor: UIColor = self.infoData.backgroundColor
  private lazy var highlightBackgroundColor: UIColor = self.infoData.highlightColor
  
  // MARK: - internal properties
  
  weak var delegate: WMPopoverfunctionContainerViewDelegate?
  
  // MARK: - life cycle
  
  init(infoData: WMPopoverContainerView.WMPopoverItem) {
    self.infoData = infoData
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - private method
  
  private func setup() {
    
    self.baseView.setSnpLayout(baseView: self, layoutConstraint: {
      $0.edges.equalToSuperview()
    })
    
    self.titleLabel.setSnpLayout(baseView: self.baseView, layoutConstraint: {
      $0.centerY.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(16)
    })
    
    self.button.setSnpLayout(baseView: self.baseView, layoutConstraint: {
      $0.edges.equalToSuperview()
    })
    
  }
  
  @objc private func touchUpInside() {
    self.delegate?.tappedFunction(infoData: self.infoData)
    self.baseView.backgroundColor = self.defaultBackgroundColor
  }
  
  @objc private func touchDown() {
    self.baseView.backgroundColor = self.highlightBackgroundColor
  }
  
  @objc private func touchUpOutside() {
    self.baseView.backgroundColor = self.defaultBackgroundColor
  }
  
  @objc private func touchCancel() {
    self.baseView.backgroundColor = self.defaultBackgroundColor
  }
  
  // MARK: - internal method
  
}

extension UIView {
  
  enum snpTypes {
    case make
    case remake
  }
  
  func setSnpLayout(baseView: UIView, snpType: snpTypes = .make, layoutConstraint: ((_ make: ConstraintMaker) -> Void)) {
    baseView.addSubview(self)
    switch snpType {
    case .make:
      self.snp.makeConstraints(layoutConstraint)
    case .remake:
      self.snp.remakeConstraints(layoutConstraint)
    }
  }
}
