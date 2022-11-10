//
//  ViewController.swift
//  YoutubePlayerTest
//
//  Created by Aaron Hanwe LEE on 2022/11/10.
//

import UIKit
import YouTubeiOSPlayerHelper

class ViewController: UIViewController {

    @IBOutlet weak var player: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player.load(withVideoId: "BY-aB72nONA")
    }

    @IBAction func playBtn(_ sender: Any) {
        self.player.playVideo()
    }
    
}

