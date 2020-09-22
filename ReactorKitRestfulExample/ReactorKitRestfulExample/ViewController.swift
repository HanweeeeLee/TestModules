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
        
        reactor.state.map{
            $0.infoData
        }.distinctUntilChanged() // 이거 호출해도 상관없는지는 모르겠음....
        .subscribe(onNext: { value in
            self.myTextView.text = value
        }).disposed(by: disposeBag)
        
        self.testBtn.rx.tap.map{
            Reactor.Action.startTestquery
        }.bind(to: reactor.action).disposed(by: disposeBag)
    }
    
    //MARK: func
    
    //MARK: action
    @IBAction func testAction(_ sender: Any) {
    }

}

