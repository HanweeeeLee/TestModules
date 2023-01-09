//
//  ViewController.swift
//  IndicatorButtonSample
//
//  Created by Aaron Hanwe LEE on 2023/01/09.
//

import UIKit
import SnapKit
import RxCocoa

class ViewController: UIViewController {
  
//  let button = IndicatorButton(lottieFileName: "Loading", type: .fullIndicator)
  let button = IndicatorButton(lottieFileName: "Loading", type: .rightIndacator(defaultImage: UIImage(named: "Sample")!))

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(button)
    button.snp.makeConstraints {
      $0.center.equalTo(self.view)
      $0.width.height.equalTo(200)
    }
    
    button.setTitle("안뇽", for: .normal)
    button.setTitle("안뇽!", for: .highlighted)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.red, for: .highlighted)
    
    button.rx.tap
      .subscribe(onNext: {
        DispatchQueue.main.async {
          self.button.startIndicator()
        }
        self.doSomething {
          DispatchQueue.main.async {
            self.button.stopIndicator()
          }
        }
      })
  }
  
  func doSomething(completion: @escaping () -> Void) {
    DispatchQueue.global().async {
      usleep(2 * 1000 * 1000)
      completion()
    }
  }


}

