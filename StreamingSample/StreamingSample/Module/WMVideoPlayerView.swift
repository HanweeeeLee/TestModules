//
//  WMVideoPlayerView.swift
//  StreamingSample
//
//  Created by hanwe on 2022/11/03.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import AVFoundation
import CoreGraphics

class WMVideoPlayerView: UIView {
    
    // MARK: UIProperty
    
    private lazy var videoContainerView = UIView().then {
        $0.backgroundColor = self.videoContainerViewColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let controllerContainerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var slider = UISlider().then {
        $0.addTarget(self, action: #selector(changeSliderValue), for: .valueChanged)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sliderTapped))
        $0.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: private property
    
    private let url: URL
    private let player = AVPlayer()
    private var playerLayer: AVPlayerLayer?
    
    var elapsedTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.elapsedTimeSecondsFloat != oldValue else { return }
            let elapsedSecondsInt = Int(self.elapsedTimeSecondsFloat)
            let elapsedTimeText = String(format: "%02d:%02d", elapsedSecondsInt.miniuteDigitInt, elapsedSecondsInt.secondsDigitInt)
            print("elapsedTimeText: \(elapsedTimeText)")
            //          self.elapsedTimeLabel.text = elapsedTimeText
            self.progressValue = self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat
        }
    }
    
    var totalTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.totalTimeSecondsFloat != oldValue else { return }
            let totalSecondsInt = Int(self.totalTimeSecondsFloat)
            let totalTimeText = String(format: "%02d:%02d", totalSecondsInt.miniuteDigitInt, totalSecondsInt.secondsDigitInt)
            print("totalTimeSecondsFloat: \(totalTimeText)")
            //          self.totalTimeLabel.text = totalTimeText
        }
    }
    
    var progressValue: Float64? {
        didSet { self.slider.value = Float(self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat) }
    }
    
    // MARK: internal property
    
    var videoContainerViewColor: UIColor = .black {
        didSet {
            self.videoContainerView.backgroundColor = self.videoContainerViewColor
        }
    }
    
    // MARK: lifeCycle
    
    init(url: URL) {
        self.url = url
        super.init(frame: .zero)
        setupUI()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer?.frame = self.videoContainerView.bounds
    }
    
    deinit {
        self.player.pause()
    }
    
    // MARK: private function
    
    private func setupUI() {
        self.addSubview(self.videoContainerView)
        self.videoContainerView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        self.addSubview(self.controllerContainerView)
        self.controllerContainerView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        self.controllerContainerView.addSubview(self.slider)
        self.slider.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.controllerContainerView)
            $0.height.equalTo(20)
        }
    }
    
    private func setup() {
        let item = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: item)
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.videoGravity = .resizeAspectFill
        self.playerLayer = playerLayer
        self.videoContainerView.layer.addSublayer(playerLayer)
        addPeriodicTimeObserver()
    }
    
    @objc private func changeSliderValue() {
        self.elapsedTimeSecondsFloat = Float64(self.slider.value) * self.totalTimeSecondsFloat
        self.player.seek(to: CMTimeMakeWithSeconds(self.elapsedTimeSecondsFloat, preferredTimescale: Int32(NSEC_PER_SEC)))
        self.player.play()
    }
    
    private func addPeriodicTimeObserver() {
        let interval = CMTimeMakeWithSeconds(1, preferredTimescale: Int32(NSEC_PER_SEC))
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] elapsedTime in
            let elapsedTimeSecondsFloat = CMTimeGetSeconds(elapsedTime)
            let totalTimeSecondsFloat = CMTimeGetSeconds(self?.player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
            guard !elapsedTimeSecondsFloat.isNaN,
                  !elapsedTimeSecondsFloat.isInfinite,
                  !totalTimeSecondsFloat.isNaN,
                  !totalTimeSecondsFloat.isInfinite else { return }
            self?.elapsedTimeSecondsFloat = elapsedTimeSecondsFloat
            self?.totalTimeSecondsFloat = totalTimeSecondsFloat
        }
    }
    
    @objc private func sliderTapped(gestureRecognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = gestureRecognizer.location(in: self.slider)
        let positionOfSlider: CGPoint = slider.frame.origin
        let widthOfSlider: CGFloat = slider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(slider.maximumValue) / widthOfSlider)
        slider.setValue(Float(newValue), animated: false)
        changeSliderValue()
    }
    
    // MARK: internal function
    
    func play() {
        self.player.play()
    }
    
}

extension Int {
  var secondsDigitInt: Int {
    self % 60
  }
  var miniuteDigitInt: Int {
    self / 60
  }
}
