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
    
    @IBAction func sendTest(_ sender: Any) {
        self.mySession.sendMessage(["호우!" : "날강두는 끝났다. 이제는 메시다"], replyHandler: nil, errorHandler: nil)
    }
    
    @IBAction func sendDataTest(_ sender: Any) {
        let sendData: Data = "메우!".data(using: .utf8)!
        self.mySession.sendMessageData(sendData, replyHandler: { value in
            print("답장이 왔다:\(String(data: value, encoding: .utf8)!)")
        }, errorHandler: { err in
            print("err:\(err.localizedDescription)")
        })
    }
    
    @IBAction func synchronizationAction(_ sender: Any) {
//        try! self.mySession.updateApplicationContext(["syncData" : "this is synchronization 과연"])
        
        mySession.activate()
    }
    
}

extension ViewController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("test1")
        if session.activationState == .activated {
            if session.isWatchAppInstalled {
                if session.isPaired {
                    print("isPaired")
                    print("activationState :\(session.activationState)")
                    if session.isReachable {
                        print("isReachable")
                    }
                    else {
                        print("so far")
                    }
                }
                else {
                    print("is not isPaired")
                }
            }
        }
        else if session.activationState == .inactive {
            
        }
        else if session.activationState == .notActivated{
            
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("test2")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("test3")
    }
    
    
    //통신 델리게이트
    
    /** 도달 가능 상태가 변경되면 호출됨. */
    func sessionReachabilityDidChange(_ session: WCSession) {
        if session.activationState == .activated {
            if session.isWatchAppInstalled {
                if session.isPaired {
                    print("isPaired")
                    print("activationState :\(session.activationState)")
                    if session.isReachable {
                        print("isReachable")
                    }
                    else {
                        print("so far")
                    }
                }
                else {
                    print("is not isPaired")
                }
            }
        }
        else if session.activationState == .inactive {
            
        }
        else if session.activationState == .notActivated{
            
        }
    }
    
    /** 발신자가 sendMessage(_:replyHandler: errorHandler: )메서드 replyHanlder를 nil로 보낸 메시지가 수신됨. */
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
    }
    
    /** 발신자가 sendMessage(_:replyHandler: errorHandler: )메서드 replyHanlder 클로저를 구현하여 보낸 메시지가 수신됨. */
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
    }
    
    /** 발신자가 sendMessageData(_:replyHandler:errorHandler:) 메서드 replyHanlder를 nil로 보낸 data가 수신됨. */
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        
    }
    
    /** 발신자가 sendMessageData(_:replyHandler:errorHandler:) 메서드 replyHanlder 클로저를 구현하여 보낸 data가 수신됨. */
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        
    }
    
    
    // background transfer
    
    /** 발신자가 udateApplicationContext(_:) 메서드를 통해 보낸 데이터가 수신됨  */
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
    }
    
    /** userInfo 전송이 완료 또는 실패한 후 송신 측에서 호출됨.  */
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        
    }
    
    /** 발신자가 transferUserInfo(_:) 메서드를 통해 보낸 데이터가 수신됨 */
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        
    }
    
    /** file 전송이 완료 또는 실패하면 송신 측에서 호출됨. */
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        
    }
    
    /** file 전송이 완료되면 호출됨. 수신된 file은 Documents/Inbox/폴더에 저장됨. 수신자는 파일을 다른 위치로 이동해야함. 이 메서드가 return되면 이동되지 않은 모든 file이 제거됨. */
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
    }
    
    
    
    
    
    
    
}
