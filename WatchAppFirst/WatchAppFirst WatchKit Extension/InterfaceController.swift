//
//  InterfaceController.swift
//  WatchAppFirst WatchKit Extension
//
//  Created by hanwe lee on 2020/11/02.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var mainContainerGroup: WKInterfaceGroup!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        print("awake")
    }
       
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("willActivate")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        print("didDeactivate")
    }
    
    @IBAction func testAction() {
        print("testAction")
    }
    
}
