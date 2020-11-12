//
//  InterfaceController.swift
//  WatchAppFirst WatchKit Extension
//
//  Created by hanwe lee on 2020/11/02.
//

import WatchKit
import Foundation
import WatchConnectivity
import EMTLoadingIndicator


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var testLoadingImg: WKInterfaceImage!
    @IBOutlet weak var loadingImgViewGroup: WKInterfaceGroup!
    @IBOutlet weak var mainContainerGroup: WKInterfaceGroup!
    @IBOutlet weak var table: WKInterfaceTable!
    
    var wcSession: WCSession = WCSession.default
    
    let numberOfRows: Int = 3
    
    private var indicator: EMTLoadingIndicator?
    
    var isLoading:Bool = false {
        didSet {
            if isLoading {
                self.loadingImgViewGroup.setHidden(false)
                self.mainContainerGroup.setHidden(true)
            }
            else {
                self.loadingImgViewGroup.setHidden(true)
                self.mainContainerGroup.setHidden(false)
            }
        }
    }
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        print("awake")
        wcSession.delegate = self
        wcSession.activate()
        print("context:\(String(describing: context))")
        indicator = EMTLoadingIndicator(interfaceController: self, interfaceImage: testLoadingImg,
                width: 40, height: 40, style: .dot)
    }
       
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("willActivate")
        self.table.setNumberOfRows(self.numberOfRows, withRowType: "Cell")
        loadTableData()
//        indicator = EMTLoadingIndicator(interfaceController: self, interfaceImage: testLoadingImg,
//                width: 40, height: 40, style: .dot)
        if !isLoading {
            self.loadingImgViewGroup.setHidden(true)
        }
        
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
        indicator?.prepareImagesForWait()
        indicator?.showWait()
    }
    
    @IBAction func testAction() {
        print("testAction")
        print("동기화 메시지입니다 :\(wcSession.receivedApplicationContext)")
//        self.presentController(withName: <#T##String#>, context: <#T##Any?#>)
        indicator = EMTLoadingIndicator(interfaceController: self, interfaceImage: testLoadingImg,
                width: 40, height: 40, style: .dot)
        self.isLoading = true
//        self.loadingImgViewGroup.setHeight(WKInterfaceDevice.current().screenBounds.height)
//        self.set
        
        indicator?.prepareImagesForWait()
        indicator?.showWait()
//        self.loading
//        self.mainContainerGroup.
        
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
