//
//  ViewController.swift
//  MinimizePanTest
//
//  Created by hanwe lee on 2020/10/05.
//

import UIKit
import SnapKit
import Hero

class ViewController: UIViewController {
    
    //MARK: outlet
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var miniView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    //MARK: property
    
    let subView:SubView = SubView.initFromNib()
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.miniView.isHidden = true
        self.hero.isEnabled = true
        self.imgView.hero.id = "abc"
        self.mainContainerView.hero.id = "mainView"
        self.myLabel.hero.id = "myLabel"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK: func
    
    //MARK: action

    @IBAction func testStart(_ sender: Any) {
        self.mainContainerView.addSubview(self.subView)
        self.subView.snp.makeConstraints({ make in
            make.leading.equalTo(self.mainContainerView.snp.leading).offset(0)
            make.trailing.equalTo(self.mainContainerView.snp.trailing).offset(0)
            make.top.equalTo(self.mainContainerView.snp.top).offset(0)
            make.bottom.equalTo(self.mainContainerView.snp.bottom).offset(0)
        })
    }
    
    @IBAction func testStart2(_ sender: Any) {
        let vc:TestViewController = TestViewController.init(nibName: "TestViewController", bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: true, completion: {
            self.miniView.isHidden = false
        })
//        let vc:TestViewController2 = TestViewController2.init(nibName: "TestViewController2", bundle: nil)
//        vc.modalPresentationStyle = .overCurrentContext
//        self.navigationController?.present(vc, animated: true, completion: {
//        })
        
    }
    
}

