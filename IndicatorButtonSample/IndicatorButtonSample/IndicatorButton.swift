//
//  IndicatorButton.swift
//  IndicatorButtonSample
//
//  Created by Aaron Hanwe LEE on 2023/01/09.
//

import UIKit
import RxSwift
import SnapKit
import Then
import RxCocoa
import Lottie


@objc protocol IndicatorButtonDelegate: AnyObject {
  @objc optional func tap(_ view: IndicatorButton)
}

final class IndicatorButton: UIView {
  
  enum LoadingType {
    case fullIndicator
    case rightIndacator(defaultImage: UIImage)
  }
  
  // MARK: - UI Property
  
  private lazy var button = UIButton().then {
    $0.setBackgroundImage(backgroundColorImage(.black), for: .normal)
    $0.setBackgroundImage(backgroundColorImage(.gray), for: .highlighted)
    $0.setBackgroundImage(backgroundColorImage(.lightGray), for: .disabled)
  }
  
  private let contentsContainerView = UIView().then {
    $0.backgroundColor = .clear
    $0.isUserInteractionEnabled = false
  }
  
  private let titleLabel = UILabel().then {
    $0.isUserInteractionEnabled = false
    $0.text = ""
    $0.textAlignment = .center
  }
  
  private lazy var lottieView = LottieAnimationView().then {
    $0.isUserInteractionEnabled = false
    $0.loopMode = .loop
    $0.animation = .named(self.lottieFileName)
    $0.contentMode = .scaleAspectFill
  }
  
  // rightIndicatorType:
  
  private let rightIndicatorDefaultImageView: UIImageView
  
  // MARK: - Private Property
  
  private let disposeBag: DisposeBag = DisposeBag()
  private let type: LoadingType
  private let lottieFileName: String
  private let loadingImageSize: CGSize
  private var normalTitleColor: UIColor = .black {
    didSet {
      self.titleLabel.textColor = normalTitleColor
    }
  }
  private var highlightedTitleColor: UIColor = .black
  private var disabledTitleColor: UIColor = .black
  
  private var normalTitle: String = "" {
    didSet {
      self.titleLabel.text = self.normalTitle
    }
  }
  private var highlightedTitle: String = ""
  private var disabledTitle: String = ""
  
  // MARK: - Internal Property
  
  var isEnabled: Bool = true {
    didSet {
      if isEnabled {
        self.titleLabel.text = self.normalTitle
        self.titleLabel.textColor = self.normalTitleColor
      } else {
        self.titleLabel.text = self.disabledTitle
        self.titleLabel.textColor = self.disabledTitleColor
      }
    }
  }
  
  weak var delegate: IndicatorButtonDelegate?
  
  // MARK: - LifeCycle
  
  init(lottieFileName: String, type: LoadingType = .fullIndicator, loadingImageSize: CGSize = .init(width: 30, height: 30)) {
    self.lottieFileName = lottieFileName
    self.type = type
    self.loadingImageSize = loadingImageSize
    switch type {
    case .rightIndacator(let defaultImage):
      self.rightIndicatorDefaultImageView = UIImageView(image: defaultImage).then {
        $0.isUserInteractionEnabled = false
      }
    case .fullIndicator:
      self.rightIndicatorDefaultImageView = UIImageView()
    }
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Func
  
  private func setup() {
    self.addSubview(self.button)
    self.button.snp.makeConstraints {
      $0.edges.equalTo(self)
    }

    button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
    button.addTarget(self, action: #selector(buttonTouchUpOutside(_:)), for: .touchUpOutside)
    button.addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
    
    switch self.type {
    case .rightIndacator:
      self.addSubview(self.contentsContainerView)
      self.contentsContainerView.snp.makeConstraints {
        $0.centerX.equalTo(self)
        $0.top.bottom.equalTo(self)
      }
      
      self.contentsContainerView.addSubview(self.rightIndicatorDefaultImageView)
      self.rightIndicatorDefaultImageView.snp.makeConstraints {
        $0.width.equalTo(self.loadingImageSize.width)
        $0.height.equalTo(self.loadingImageSize.height)
        $0.trailing.equalTo(self.contentsContainerView)
        $0.centerY.equalTo(self)
      }
      
      self.contentsContainerView.addSubview(self.lottieView)
      self.lottieView.snp.makeConstraints {
        $0.width.equalTo(self.loadingImageSize.width)
        $0.height.equalTo(self.loadingImageSize.height)
        $0.trailing.equalTo(self.contentsContainerView)
        $0.centerY.equalTo(self)
      }
      self.lottieView.isHidden = true
      
      self.contentsContainerView.addSubview(self.titleLabel)
      self.titleLabel.snp.makeConstraints {
        $0.leading.equalTo(self.contentsContainerView)
        $0.trailing.equalTo(self.rightIndicatorDefaultImageView.snp.leading).offset(-4)
        $0.centerY.equalTo(self.rightIndicatorDefaultImageView)
      }
    case .fullIndicator:
      self.addSubview(self.contentsContainerView)
      self.contentsContainerView.snp.makeConstraints {
        $0.centerX.equalTo(self)
        $0.top.bottom.equalTo(self)
      }
      
      self.contentsContainerView.addSubview(self.lottieView)
      self.lottieView.snp.makeConstraints {
        $0.width.equalTo(self.loadingImageSize.width)
        $0.height.equalTo(self.loadingImageSize.height)
        $0.center.equalTo(self)
      }
      self.lottieView.isHidden = true
      
      self.contentsContainerView.addSubview(self.titleLabel)
      self.titleLabel.snp.makeConstraints {
        $0.leading.trailing.equalTo(self)
        $0.centerY.equalTo(self)
      }
    }
    
  }
  
  private func backgroundColorImage(_ color: UIColor) -> UIImage {
    UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
    guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
    context.setFillColor(color.cgColor)
    context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
    
    let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return backgroundImage ?? UIImage()
  }
  
  @objc private func buttonTouchDown(_ sender: UIButton) {
    self.titleLabel.text = self.highlightedTitle
    self.titleLabel.textColor = self.highlightedTitleColor
  }
  
  @objc private func buttonTouchUpInside(_ sender: UIButton) {
    self.titleLabel.text = self.normalTitle
    self.titleLabel.textColor = self.normalTitleColor
    self.delegate?.tap?(self)
  }
  
  @objc private func buttonTouchUpOutside(_ sender: UIButton) {
    self.titleLabel.text = self.normalTitle
    self.titleLabel.textColor = self.normalTitleColor
  }
  
  // MARK: - Internal Func
  
  func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    self.button.setBackgroundImage(backgroundColorImage(color), for: state)
  }
  
  func setTitle(_ text: String, for state: UIControl.State) {
    switch state {
    case .highlighted:
      self.highlightedTitle = text
    case .normal:
      self.normalTitle = text
    case .disabled:
      self.disabledTitle = text
    default:
      break
    }
  }
  
  func setTitleAllState(_ text: String) {
    self.highlightedTitle = text
    self.normalTitle = text
    self.disabledTitle = text
  }
  
  func setTitleColor(_ color: UIColor, for state: UIControl.State) {
    switch state {
    case .highlighted:
      self.highlightedTitleColor = color
    case .normal:
      self.normalTitleColor = color
    case .disabled:
      self.disabledTitleColor = color
    default:
      break
    }
  }
  
  func startIndicator() {
    DispatchQueue.main.async { [weak self] in
      switch self?.type {
      case .fullIndicator:
        self?.titleLabel.isHidden = true
        self?.lottieView.play()
        self?.lottieView.isHidden = false
      case .rightIndacator:
        self?.rightIndicatorDefaultImageView.isHidden = true
        self?.lottieView.play()
        self?.lottieView.isHidden = false
      case .none:
        break
      }
    }
  }
  
  func stopIndicator() {
    DispatchQueue.main.async { [weak self] in
      switch self?.type {
      case .fullIndicator:
        self?.titleLabel.isHidden = false
        self?.lottieView.stop()
        self?.lottieView.isHidden = true
      case .rightIndacator:
        self?.rightIndicatorDefaultImageView.isHidden = false
        self?.lottieView.stop()
        self?.lottieView.isHidden = true
      case .none:
        break
      }
      
    }
  }
  
}

class IndicatorButtonDelegateProxy: DelegateProxy<IndicatorButton, IndicatorButtonDelegate>, DelegateProxyType, IndicatorButtonDelegate {
  
  static func registerKnownImplementations() {
    self.register { (viewController) -> IndicatorButtonDelegateProxy in
      IndicatorButtonDelegateProxy(parentObject: viewController, delegateProxy: self)
    }
  }
  
  static func currentDelegate(for object: IndicatorButton) -> IndicatorButtonDelegate? {
    return object.delegate
  }
  
  static func setCurrentDelegate(_ delegate: IndicatorButtonDelegate?, to object: IndicatorButton) {
    object.delegate = delegate
  }
  
}

extension Reactive where Base == IndicatorButton {
  
  var delegate: DelegateProxy<IndicatorButton, IndicatorButtonDelegate> {
    return IndicatorButtonDelegateProxy.proxy(for: self.base)
  }
  
  var tap: Observable<Void> {
    return delegate.methodInvoked(#selector(IndicatorButtonDelegate.tap(_:)))
      .map { param in
        return ()
      }
  }
  
}
