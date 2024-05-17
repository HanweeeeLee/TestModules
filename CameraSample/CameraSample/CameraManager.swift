//
//  CameraManager.swift
//  CameraSample
//
//  Created by Aaron Hanwe LEE on 5/17/24.
//

import AVFoundation
import UIKit
import Combine

class CameraManager: NSObject, ObservableObject {
  let session = AVCaptureSession()
  private var photoOutput = AVCapturePhotoOutput()
  private let sessionQueue = DispatchQueue(label: "sessionQueue")
  @Published var isSessionRunning = false
  @Published var capturedImage: UIImage?
  
  override init() {
    super.init()
    configureSession()
  }
  
  func configureSession() {
    session.beginConfiguration()
    session.sessionPreset = .photo
    
    guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
          let input = try? AVCaptureDeviceInput(device: camera),
          session.canAddInput(input),
          session.canAddOutput(photoOutput) else {
      print("Failed to set up device input or output")
      return
    }
    
    session.addInput(input)
    session.addOutput(photoOutput)
    session.commitConfiguration()
  }
  
  func startSession() {
    if !isSessionRunning {
      sessionQueue.async {
        self.session.startRunning()
        DispatchQueue.main.async {
          self.isSessionRunning = true
        }
      }
    }
  }
  
  func stopSession() {
    if isSessionRunning {
      sessionQueue.async {
        self.session.stopRunning()
        DispatchQueue.main.async {
          self.isSessionRunning = false
        }
      }
    }
  }
  
  func takePhoto() {
    let settings = AVCapturePhotoSettings()
    photoOutput.capturePhoto(with: settings, delegate: self)
  }
  
  func switchCamera() {
    sessionQueue.async {
      self.session.beginConfiguration()
      guard let currentInput = self.session.inputs.first as? AVCaptureDeviceInput else { return }
      self.session.removeInput(currentInput)
      
      let newCamera = currentInput.device.position == .back ? self.getCamera(.front) : self.getCamera(.back)
      guard let newInput = try? AVCaptureDeviceInput(device: newCamera),
            self.session.canAddInput(newInput) else { return }
      
      self.session.addInput(newInput)
      self.session.commitConfiguration()
    }
  }
  
  private func getCamera(_ position: AVCaptureDevice.Position) -> AVCaptureDevice {
    return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) ?? AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
  }
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    guard let imageData = photo.fileDataRepresentation(),
          let image = UIImage(data: imageData) else {
      print("Failed to get image data")
      return
    }
    
    DispatchQueue.main.async {
      self.capturedImage = image
    }
  }
}
