//
//  TextViewWrapper.swift
//  TouchableText
//
//  Created by Aaron Hanwe LEE on 12/5/24.
//

import SwiftUI
import UIKit

struct TextViewWrapper: UIViewRepresentable {
    var attributedText: NSAttributedString
    
    func makeUIView(context: Context) -> UITextView {
        let uiView = UITextView()

        uiView.backgroundColor = .clear
        uiView.textContainerInset = .zero
        uiView.isEditable = false
        uiView.isScrollEnabled = false
        uiView.textContainer.lineFragmentPadding = 0
        
        return uiView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedText
    }
}
