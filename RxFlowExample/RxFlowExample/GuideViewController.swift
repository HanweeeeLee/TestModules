//
//  GuideViewController.swift
//  RxFlowExample
//
//  Created by hanwe on 2021/09/22.
//

import RxFlow
import RxSwift
import RxCocoa
import UIKit

class GuideViewController: UIViewController, Stepper {
    
    var steps: PublishRelay<Step> = PublishRelay<Step>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func confirmAction(_ sender: Any) {
        steps.accept(MyStep.guideIsComplited)
    }
}
