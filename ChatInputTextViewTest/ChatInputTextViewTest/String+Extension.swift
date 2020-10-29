
import Foundation
import UIKit

extension String {
    
    public func heightForWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [kCTFontAttributeName as NSAttributedString.Key: font],
            context: nil
        )
        return ceil(rect.height)
    }
    
    public func getSizeString(font: UIFont) -> CGSize {
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [kCTFontAttributeName as NSAttributedString.Key: font],
            context: nil
        )
        return rect.size
    }
    
    public func evaluateStringWidth (font: UIFont) -> CGFloat{
        let fontAttributes = [NSAttributedString.Key.font: font]
        let myText = self
        let size = (myText as NSString).size(withAttributes: fontAttributes)
        return size.width
    }
    
}
