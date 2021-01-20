//
//  ViewController.swift
//  BlueToothTestCentral
//
//  Created by hanwe lee on 2021/01/20.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    var centralManager: CBCentralManager? = nil
    let myQueue = DispatchQueue.init(label: "myQueue")
    var searchedPeripheral: CBPeripheral? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.myQueue
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil, options: nil)
    }
    
    @IBAction func testStart(_ sender: Any) {
        print("push")
        centralManager?.scanForPeripherals(withServices: [CBUUID(string: "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX")], options: nil)
    }
    
}

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("did update State")
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("찾았다!:\(String(describing: peripheral.name)),\n\(peripheral.services)")

//        self.centralManager?.cancelPeripheralConnection(peripheral)
//
        self.searchedPeripheral = peripheral
        self.centralManager?.connect(peripheral, options: [CBConnectPeripheralOptionNotifyOnConnectionKey : true])
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("?")
        print("연결 성공 : \(String(describing: peripheral.name))")
        let alert = UIAlertController(title: "성공", message: "peripheral.name:\(String(describing: peripheral.name))", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let peripheral = self.searchedPeripheral {
                
//                self.centralManager?.cancelPeripheralConnection(peripheral)
//                peripheral.writeValue(<#T##data: Data##Data#>, for: <#T##CBDescriptor#>)
                let dataCharacteristic = peripheral.services![0].characteristics![0]
                
                peripheral.writeValue("hi".data(using: .utf8)!, for: dataCharacteristic, type: .withoutResponse)
//                self.centralManager?
            }
        }
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("disconnect:\(peripheral.name)")
    }
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("연결 실패 : \(String(describing: peripheral.name))")
    }
    
    
}

