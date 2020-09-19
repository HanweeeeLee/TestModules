//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
    //Observable의 생명주기
    // 1. Create
    // 2. Subscribe
    // 3. onNext
    // --- 끝 ---
    // 4. onCompleted // or onError
    // 5. Disposed
    
    func downloadJson(_ url:String) -> Observable<String?>{
//        return Observable.just("helloWorld") //suger api //operator
//        return Observable.from(["hello","world"]) //suger api //operator
        return Observable.create() { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                if let dat = data, let json = String(data: dat, encoding: .utf8) {
                    emitter.onNext(json)
                }
                
                emitter.onCompleted()
            })
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
            
        }
    }
    
    // MARK: SYNC
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        downloadJson(MEMBER_LIST_URL)
            .debug()
//            .subscribe(onNext: { print($0)}) //suger //operator
            .subscribe { event in
                switch event {
                case let .next(json):
                    DispatchQueue.main.async {
                        self.editView.text = json
                    }
                    break
                case .error(_):
                    break
                case .completed:
                    break
                }
            }
        
    }
}
