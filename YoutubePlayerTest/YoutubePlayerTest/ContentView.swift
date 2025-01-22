//
//  ContentView.swift
//  YoutubePlayerTest
//
//  Created by Aaron Hanwe LEE on 1/17/25.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)?playsinline=1") else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("YouTube Player")
                .font(.title)
                .padding()
            
            YouTubePlayerView(videoID: "Q89Dzox4jAE") // YouTube 영상 ID
                .frame(height: 300) // 원하는 높이와 너비로 조정
        }
    }
}
