//
//  ViewController.swift
//  ReactorKitRestfulExample
//
//  Created by hanwe lee on 2020/09/22.
//

import UIKit
import SwiftyJSON
import ReactorKit
import RxCocoa

class ViewController: UIViewController,StoryboardView {

    //MARK: outlet
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    //MARK: property
    
    var disposeBag:DisposeBag = DisposeBag()
    
    let viewModel:ViewModel = ViewModel()
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = self.viewModel
    }
    
    func bind(reactor: ViewModel) {
        reactor.action.onNext(.startTestquery)
    }
    
    //MARK: func
    
    //MARK: action
    @IBAction func testAction(_ sender: Any) {
    }
    
   


}

