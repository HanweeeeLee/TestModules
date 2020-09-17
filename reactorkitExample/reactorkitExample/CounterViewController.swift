//
//  ViewController.swift
//  reactorkitExample
//
//  Created by hanwe lee on 2020/09/17.
//

import ReactorKit
import RxCocoa
import RxSwift

import UIKit

class CounterViewController: UIViewController,StoryboardView {

    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var disposeBag:DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func bind(reactor: CounterViewReactor) {
        //Action
        increaseButton.rx.tap
            .map{ Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map{ Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map{ $0.value }
            .distinctUntilChanged()
            .map{ "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map{ $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    


}

