//
//  ContentView.swift
//  TouchableText
//
//  Created by Aaron Hanwe LEE on 12/5/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Text("Start")
      //          TappablePieceOfText()
      AttributedText(NSAttributedString(
        string: "Hello, world!Hello, world!Hello,\n world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!",
        attributes: [
          .font: UIFont.preferredFont(forTextStyle: .body),
          .backgroundColor: UIColor.yellow
        ]
      )) { attributes in
        print("호잇: \(attributes)")
      }
      
      Text("Hello World!")
      
      
      
      
      Spacer()
    }
    .padding()
  }
  
  private func createAttributedString() -> NSAttributedString {
    let attributedString = NSMutableAttributedString(
      string: "This is a clickable link to OpenAI.",
      attributes: [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.label
      ]
    )
    // "clickable link" 부분에 링크 추가
    let linkRange = (attributedString.string as NSString).range(of: "clickable link")
    attributedString.addAttributes([
      .link: URL(string: "https://www.openai.com")!,
      .foregroundColor: UIColor.systemBlue,
      .underlineStyle: NSUnderlineStyle.single.rawValue
    ], range: linkRange)
    
    return attributedString
  }
}
