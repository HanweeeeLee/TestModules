//
//  InterfaceController.swift
//  WatchAppFirst WatchKit Extension
//
//  Created by hanwe lee on 2020/11/02.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var mainContainerGroup: WKInterfaceGroup!
    @IBOutlet weak var table: WKInterfaceTable!
    
    var wcSession: WCSession = WCSession.default
    
    let numberOfRows: Int = 3
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        print("awake")
        wcSession.delegate = self
        wcSession.activate()
        print("context:\(String(describing: context))")
    }
       
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("willActivate")
        self.table.setNumberOfRows(self.numberOfRows, withRowType: "Cell")
        loadTableData()
    }
    
    private func loadTableData() {
        
        table.setNumberOfRows(numberOfRows, withRowType: "IconTextTypeRowController")
        
        for i in 0 ..< self.numberOfRows {
//            let row: IconTextTypeRowController = table.rowController(at: i) as! IconTextTypeRowController
            let row = table.rowController(at: i) as! IconTextTypeRowController
            print("row:\(row)")
            row.showItem(title: "123", imageName: "sample")
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        print("didDeactivate")
        
    }
    
    @IBAction func testAction() {
        print("testAction")
        print("동기화 메시지입니다 :\(wcSession.receivedApplicationContext)")
    }
    
}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("is Active")
        print("동기화 메시지입니다 :\(session.receivedApplicationContext)")
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("userInfo:\(userInfo)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("message:\(message)")
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        
//        messageData
    }
    
    
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        print("뭔가 왔는디?: \(String(data: messageData, encoding: .utf8)!)")
        replyHandler("얘, 데이터가 왔단다.".data(using: .utf8)!)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("호출되나?")
        print("동기화 메시지입니다 :\(session.receivedApplicationContext)")
        
        
    }
    
}
