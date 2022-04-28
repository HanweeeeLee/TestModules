//
//  ViewController.swift
//  ShimmerProtocolTest
//
//  Created by Hanwe LEE on 2022/04/26.
//

import UIKit
import SnapKit

class ViewController: UIViewController, AttachViewProtocol {
    weak var targetView: UIView?
    var attachedView: UIView?
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.targetView = self.containerView
        self.attachedView = MyShimmerView()
        guard let attachedView = attachedView else { return }
        self.containerView.addSubview(attachedView)
        attachedView.snp.makeConstraints {
            $0.edges.equalTo(self.containerView.snp.edges)
        }
        
    }

    @IBAction func testAction(_ sender: Any) {
        (self.attachedView as? MyShimmerView)?.startAnimation()
    }
    
    @IBAction func testStop(_ sender: Any) {
        (self.attachedView as? MyShimmerView)?.stopAnimation()
    }
    
}
