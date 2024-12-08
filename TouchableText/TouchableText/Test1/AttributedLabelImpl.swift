//
//  AttributedLabelImpl.swift
//  TouchableText
//
//  Created by Aaron Hanwe LEE on 12/6/24.
//

import SwiftUI

struct AttributedLabelImpl {
  var attributedText: NSAttributedString
  var maxLayoutWidth: CGFloat
  var textSizeViewModel: TextSizeViewModel
  var onOpenLink: (([NSAttributedString.Key: Any]) -> Void)?
}

extension AttributedLabelImpl: UIViewRepresentable {
  func makeUIView(context: Context) -> LabelView {
    LabelView()
  }
  
  func updateUIView(_ uiView: LabelView, context: Context) {
    uiView.attributedText = attributedText
    uiView.maxLayoutWidth = maxLayoutWidth
    uiView.onOpenLink = onOpenLink
    
    textSizeViewModel.didUpdateTextView(uiView)
  }
}

extension AttributedLabelImpl {
  final class LabelView: UILabel {
    var maxLayoutWidth: CGFloat = 0 {
      didSet {
        guard maxLayoutWidth != oldValue else { return }
        invalidateIntrinsicContentSize()
      }
    }
    
    var onOpenLink: (([NSAttributedString.Key: Any]) -> Void)?
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.isUserInteractionEnabled = true
      self.numberOfLines = 0
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
      self.numberOfLines = 2
      self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
      guard maxLayoutWidth > 0 else {
        return super.intrinsicContentSize
      }
      
      let size = self.sizeThatFits(CGSize(width: maxLayoutWidth, height: .greatestFiniteMagnitude))
      return CGSize(width: size.width, height: size.height)
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
      let location = sender.location(in: self)
      guard let text = self.attributedText else { return }
      
      let index = characterIndex(at: location)
      let attributes = text.attributes(at: index, effectiveRange: nil)
      onOpenLink?(attributes)
    }
    
    private func characterIndex(at location: CGPoint) -> Int {
      guard let text = self.attributedText else { return 0 }
      
      let textStorage = NSTextStorage(attributedString: text)
      let layoutManager = NSLayoutManager()
      let textContainer = NSTextContainer(size: self.bounds.size)
      textContainer.lineFragmentPadding = 0
      textStorage.addLayoutManager(layoutManager)
      layoutManager.addTextContainer(textContainer)
      
      let locationInTextContainer = CGPoint(
        x: location.x,
        y: location.y
      )
      return layoutManager.characterIndex(
        for: locationInTextContainer,
        in: textContainer,
        fractionOfDistanceBetweenInsertionPoints: nil
      )
    }
  }
}
