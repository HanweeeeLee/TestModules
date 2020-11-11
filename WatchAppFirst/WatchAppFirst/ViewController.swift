//
//  ViewController.swift
//  WatchAppFirst
//
//  Created by hanwe lee on 2020/11/02.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {
    
    var mySession: WCSession = WCSession.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if WCSession.isSupported() {
            mySession.delegate = self
            mySession.activate()
            
        }
    }


}

extension ViewController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("test1")
        if session.activationState == .activated {
            if session.isWatchAppInstalled {
                print("호우! : \(self.mySession) ddddddd   \(session)")
                if session.isPaired {
                    print("isPaired")
                    print("activationState :\(session.activationState)")
                }
                else {
                    print("is not isPaired")
                }
            }
        }
        else if session.activationState == .inactive {
            
        }
        else {
            
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("test2")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("test3")
    }
}
