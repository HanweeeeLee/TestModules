//
//  ContentView.swift
//  CameraSample
//
//  Created by Aaron Hanwe LEE on 5/17/24.
//

import SwiftUI
import AVFoundation
import Combine
import UIKit

struct ContentView: View {
  @StateObject var cameraManager = CameraManager()
  
  var body: some View {
    VStack {
      ZStack {
        CameraView(cameraManager: cameraManager)
        VStack {
          Spacer()
          HStack {
            Spacer()
            Button(action: {
              cameraManager.switchCamera()
            }) {
              Image(systemName: "camera.rotate")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color.white.opacity(0.7))
                .clipShape(Circle())
            }
            .padding()
          }
        }
      }
      .frame(height: UIScreen.main.bounds.height / 2)
      
      if let capturedImage = cameraManager.capturedImage {
        Image(uiImage: capturedImage)
          .resizable()
          .scaledToFit()
          .frame(height: UIScreen.main.bounds.height / 2)
      } else {
        Spacer()
      }
      
      Button(action: {
        cameraManager.takePhoto()
      }) {
        Text("Take Photo")
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .clipShape(Circle())
          .padding(.bottom)
      }
    }
  }
}

#Preview {
  ContentView()
}

import SwiftUI

struct CameraView: UIViewRepresentable {
  @ObservedObject var cameraManager: CameraManager
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: UIScreen.main.bounds)
    let previewLayer = AVCaptureVideoPreviewLayer(session: cameraManager.session)
    previewLayer.videoGravity = .resizeAspectFill
    previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
    view.layer.addSublayer(previewLayer)
    cameraManager.startSession()
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}
