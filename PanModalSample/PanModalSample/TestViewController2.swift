//
//  TestViewController2.swift
//  PanModalSample
//
//  Created by hanwe on 2021/09/17.
//

import UIKit
import PanModal

class TestViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension TestViewController2: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }
}
