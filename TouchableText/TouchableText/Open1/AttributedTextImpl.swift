//import SwiftUI
//
//struct AttributedTextImpl {
//  var attributedText: NSAttributedString
//  var maxLayoutWidth: CGFloat
//  var textSizeViewModel: TextSizeViewModel
//  var onOpenLink: (([NSAttributedString.Key : Any]) -> Void)?
//}
//
//extension AttributedTextImpl: UIViewRepresentable {
//  func makeUIView(context: Context) -> TextView {
//    TextView()
//  }
//  
//  func updateUIView(_ uiView: TextView, context: Context) {
//    uiView.attributedText = attributedText
//    uiView.maxLayoutWidth = maxLayoutWidth
//    
//    uiView.textContainer.maximumNumberOfLines = context.environment.lineLimit ?? 0
//    uiView.textContainer.lineBreakMode = NSLineBreakMode(
//      truncationMode: context.environment.truncationMode
//    )
//    uiView.openLink = onOpenLink
//    textSizeViewModel.didUpdateTextView(uiView)
//  }
//}
//
//extension AttributedTextImpl {
//  final class TextView: UITextView {
//    var maxLayoutWidth: CGFloat = 0 {
//      didSet {
//        guard maxLayoutWidth != oldValue else { return }
//        invalidateIntrinsicContentSize()
//      }
//    }
//    
//    var openLink: (([NSAttributedString.Key : Any]) -> Void)?
//    
//    override init(frame: CGRect, textContainer: NSTextContainer?) {
//      super.init(frame: frame, textContainer: textContainer)
//      
//      self.backgroundColor = .clear
//      self.textContainerInset = .zero
//      self.isEditable = false
//      self.isSelectable = false
//      self.isScrollEnabled = false
//      self.textContainer.lineFragmentPadding = 0
//      
//      self.addGestureRecognizer(
//        UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
//      )
//    }
//    
//    required init?(coder: NSCoder) {
//      fatalError("init(coder:) has not been implemented")
//    }
//    
//    override var intrinsicContentSize: CGSize {
//      guard maxLayoutWidth > 0 else {
//        return super.intrinsicContentSize
//      }
//      
//      return sizeThatFits(CGSize(width: maxLayoutWidth, height: .greatestFiniteMagnitude))
//    }
//    
//    @objc func handleTap(sender: UITapGestureRecognizer) {
//      let location = sender.location(in: self)
//      
//        // 터치된 위치의 모든 속성을 가져옵니다.
//        let index = indexOfCharacter(at: location)
//        guard let attributedText = self.attributedText else { return }
//        
//        let attributes = attributedText.attributes(at: index, effectiveRange: nil)
////        print("Attributes at tapped location: \(attributes)")
//      openLink?(attributes)
//    }
//    
//    private func url(at location: CGPoint) -> URL? {
//      guard let attributedText = self.attributedText else { return nil }
//      
//      let index = indexOfCharacter(at: location)
//      return attributedText.attribute(.link, at: index, effectiveRange: nil) as? URL
//    }
//    
//    private func indexOfCharacter(at location: CGPoint) -> Int {
//      let locationInTextContainer = CGPoint(
//        x: location.x - self.textContainerInset.left,
//        y: location.y - self.textContainerInset.top
//      )
//      return self.layoutManager.characterIndex(
//        for: locationInTextContainer,
//        in: self.textContainer,
//        fractionOfDistanceBetweenInsertionPoints: nil
//      )
//    }
//  }
//}
