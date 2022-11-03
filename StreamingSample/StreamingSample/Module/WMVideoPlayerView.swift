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
    
    enum VideoState {
        case playing
        case pause
        case end
    }
    
    // MARK: UIProperty
    
    private lazy var videoContainerView = UIView().then {
        $0.backgroundColor = self.videoContainerViewColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var controllerContainerView = UIView().then {
        $0.backgroundColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.controllerContainerViewTap))
        $0.addGestureRecognizer(tap)
    }
    
    private lazy var innerControllerContainerView = UIView().then {
        $0.backgroundColor = self.controllerDimmColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.innerControllerContainerViewTap))
        tap.delegate = self
        $0.addGestureRecognizer(tap)
    }
    
    private lazy var slider = UISlider().then {
        $0.addTarget(self, action: #selector(changeSliderValue), for: .valueChanged)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sliderTapped))
        $0.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private lazy var centerBtn = UIButton().then {
        $0.setTitle("플레이", for: .normal)
        $0.addTarget(self, action: #selector(centerBtnClicked), for: .touchUpInside)
    }
    
    private lazy var muteBtn = UIButton().then {
        $0.setTitle("음소거On", for: .normal)
        $0.addTarget(self, action: #selector(muteBtnClicked), for: .touchUpInside)
    }
    
    private lazy var forwardBtn = UIButton().then {
        $0.setTitle(">", for: .normal)
        $0.addTarget(self, action: #selector(forwardBtnClicked), for: .touchUpInside)
    }
    
    private lazy var backwardBtn = UIButton().then {
        $0.setTitle("<", for: .normal)
        $0.addTarget(self, action: #selector(backwardBtnClicked), for: .touchUpInside)
    }
    
    // MARK: private property
    
    private let url: URL
    private let player = AVPlayer().then {
        $0.isMuted = true
    }
    private var playerLayer: AVPlayerLayer?
    
    private var elapsedTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.elapsedTimeSecondsFloat != oldValue else { return }
            let elapsedSecondsInt = Int(self.elapsedTimeSecondsFloat)
            let elapsedTimeText = String(format: "%02d:%02d", elapsedSecondsInt.miniuteDigitInt, elapsedSecondsInt.secondsDigitInt)
            print("elapsedTimeText: \(elapsedTimeText)")
            //          self.elapsedTimeLabel.text = elapsedTimeText
            self.progressValue = self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat
        }
    }
    
    private var totalTimeSecondsFloat: Float64 = 0 {
        didSet {
            guard self.totalTimeSecondsFloat != oldValue else { return }
            let totalSecondsInt = Int(self.totalTimeSecondsFloat)
            let totalTimeText = String(format: "%02d:%02d", totalSecondsInt.miniuteDigitInt, totalSecondsInt.secondsDigitInt)
            print("totalTimeSecondsFloat: \(totalTimeText)")
            //          self.totalTimeLabel.text = totalTimeText
        }
    }
    
    private var progressValue: Float64? {
        didSet { self.slider.value = Float(self.elapsedTimeSecondsFloat / self.totalTimeSecondsFloat) }
    }
    
    private var videoState: VideoState = .pause {
        didSet {
            switch self.videoState {
            case .pause:
                self.refreshPauseStateUI()
            case .playing:
                self.refreshPlayingStateUI()
            case .end:
                self.refreshEndStateUI()
            }
        }
    }
    
    private var isHiddenVideoContainerView: Bool = false {
        didSet {
            if self.isHiddenVideoContainerView {
                self.refreshHideControllerContainerView()
            } else {
                self.refreshShowControllerContainerView()
            }
        }
    }
    
    private var isMute: Bool = true {
        didSet {
            if self.isMute {
                self.muteBtn.setTitle("음소거 On", for: .normal)
                self.player.isMuted = true
            } else {
                self.muteBtn.setTitle("음소거 Off", for: .normal)
                self.player.isMuted = false
            }
        }
    }
    
    // MARK: internal property
    
    var videoContainerViewColor: UIColor = .black {
        didSet {
            self.videoContainerView.backgroundColor = self.videoContainerViewColor
        }
    }
    
    var controllerDimmColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3) {
        didSet {
            self.controllerContainerView.backgroundColor = self.controllerDimmColor
        }
    }
    
    var skipTime: CGFloat = 1 // 앞으로가기 뒤로가기 시간
    
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
        
        self.controllerContainerView.addSubview(self.innerControllerContainerView)
        self.innerControllerContainerView.snp.makeConstraints {
            $0.edges.equalTo(self.controllerContainerView)
        }
        
        self.innerControllerContainerView.addSubview(self.slider)
        self.slider.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.innerControllerContainerView)
            $0.height.equalTo(20)
        }
        
        self.innerControllerContainerView.addSubview(self.centerBtn)
        self.centerBtn.snp.makeConstraints {
            $0.center.equalTo(self.innerControllerContainerView)
            $0.width.height.equalTo(100)
        }
        
        self.innerControllerContainerView.addSubview(self.forwardBtn)
        self.forwardBtn.snp.makeConstraints {
            $0.leading.equalTo(self.centerBtn.snp.trailing)
            $0.centerY.equalTo(self.centerBtn)
        }
        
        self.innerControllerContainerView.addSubview(self.backwardBtn)
        self.backwardBtn.snp.makeConstraints {
            $0.trailing.equalTo(self.centerBtn.snp.leading)
            $0.centerY.equalTo(self.centerBtn)
        }
        
        self.innerControllerContainerView.addSubview(self.muteBtn)
        self.muteBtn.snp.makeConstraints {
            $0.leading.top.equalTo(self.innerControllerContainerView)
            $0.width.height.equalTo(100)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleApplicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleApplicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endVideoNotiRecieve), name: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)
    }
    
    @objc private func changeSliderValue() {
        self.elapsedTimeSecondsFloat = Float64(self.slider.value) * self.totalTimeSecondsFloat
        self.player.seek(to: CMTimeMakeWithSeconds(self.elapsedTimeSecondsFloat, preferredTimescale: Int32(NSEC_PER_SEC)))
    }
    
    @objc private func controllerContainerViewTap() {
        if self.videoState != .end {
            self.isHiddenVideoContainerView = !self.isHiddenVideoContainerView
        }
    }
    
    @objc private func innerControllerContainerViewTap() {
        
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
    
    @objc private func handleApplicationWillResignActive(_ aNotification: Notification) {
        switch self.videoState {
        case .playing:
            pause()
        case .end, .pause:
            break
        }
    }

    @objc private func handleApplicationDidEnterBackground(_ aNotification: Notification) {
        switch self.videoState {
        case .playing:
            pause()
        case .end, .pause:
            break
        }
    }
    
    private func playFromStart() {
        self.player.seek(to: .zero)
        play()
    }
    
    private func play() { // play state는 여기서만 set 해주자
        self.videoState = .playing
        self.player.play()
    }
    
    private func pause() { // pause state는 여기서만 set 해주자
        self.videoState = .pause
        self.player.pause()
    }
    
    private func end() { // end state는 여기서만 set 해주자
        self.videoState = .end
        self.isHiddenVideoContainerView = false
    }
    
    private func refreshPlayingStateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.centerBtn.setTitle("포즈", for: .normal)
        }
    }
    
    private func refreshPauseStateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.centerBtn.setTitle("플레이", for: .normal)
        }
    }
    
    private func refreshEndStateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.centerBtn.setTitle("다시 ㄱ", for: .normal)
        }
    }
    
    @objc private func centerBtnClicked() {
        switch self.videoState {
        case .end:
            playFromStart()
        case .playing:
            pause()
        case .pause:
            play()
        }
    }
    
    @objc private func muteBtnClicked() {
        self.isMute = !self.isMute
    }
    
    @objc private func forwardBtnClicked() {
        // TODO: 구현
    }
    
    @objc private func backwardBtnClicked() {
        // TODO: 구현
    }
    
    @objc private func endVideoNotiRecieve() {
        end()
    }
    
    private func refreshHideControllerContainerView() {
        DispatchQueue.main.async { [weak self] in
            self?.innerControllerContainerView.fadeOut(completeHandler: { [weak self] in
                self?.innerControllerContainerView.isHidden = true
            })
        }
    }
    
    private func refreshShowControllerContainerView() {
        DispatchQueue.main.async { [weak self] in
            self?.innerControllerContainerView.isHidden = false
            self?.innerControllerContainerView.fadeIn(completeHandler: nil)
        }
    }
    
    // MARK: internal function
    
}

extension WMVideoPlayerView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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

extension UIView {
    func fadeOut(duration: TimeInterval = 0.2, completeHandler: (() -> Void)?) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.alpha = 0.0
        }, completion: { (finished: Bool) -> Void in
            if finished {
                completeHandler?()
            }
        })
    }

    func fadeIn(duration: TimeInterval = 0.2, completeHandler: (() -> Void)?) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.alpha = 1.0
        }, completion: { (finished: Bool) -> Void in
            if finished {
                completeHandler?()
            }
        })
    }
}

