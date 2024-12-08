import SwiftUI

final class TextSizeViewModel {
  @Published var textSize: CGSize?

  func didUpdateTextView(_ textView: AttributedLabelImpl.LabelView) {
    textSize = textView.intrinsicContentSize
  }
}
