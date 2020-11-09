//
//  PasswordInterfaceController.swift
//  WatchAppFirst WatchKit Extension
//
//  Created by hanwe lee on 2020/11/09.
//

import WatchKit
import Foundation

class PasswordInterfaceController: WKInterfaceController {
    //MARK: define
    enum PWInterfaceControllerNumberPadEnum {
        case zero
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
    }
    
    //MARK: outlet
    @IBOutlet weak var group1: WKInterfaceGroup!
    @IBOutlet weak var group2: WKInterfaceGroup!
    @IBOutlet weak var group3: WKInterfaceGroup!
    @IBOutlet weak var group4: WKInterfaceGroup!
    
    @IBOutlet weak var number1btn: WKInterfaceButton!
    @IBOutlet weak var number2btn: WKInterfaceButton!
    @IBOutlet weak var number3btn: WKInterfaceButton!
    @IBOutlet weak var number4btn: WKInterfaceButton!
    @IBOutlet weak var number5btn: WKInterfaceButton!
    @IBOutlet weak var number6btn: WKInterfaceButton!
    @IBOutlet weak var number7btn: WKInterfaceButton!
    @IBOutlet weak var number8btn: WKInterfaceButton!
    @IBOutlet weak var number9btn: WKInterfaceButton!
    @IBOutlet weak var number0btn: WKInterfaceButton!
    
    @IBOutlet weak var pwImgInterface: WKInterfaceImage!
    
    @IBOutlet weak var backspaceBtn: WKInterfaceButton!
    
    //MARK: property
    
    var inputPW: String = "" {
        didSet {
            print("inputPW:\(self.inputPW)")
            if self.inputPW.count == 0 {
                self.pwImgInterface.setImage(UIImage(named: "pw0"))
            }
            else if self.inputPW.count == 1 {
                self.pwImgInterface.setImage(UIImage(named: "pw1"))
            }
            else if self.inputPW.count == 2 {
                self.pwImgInterface.setImage(UIImage(named: "pw2"))
            }
            else if self.inputPW.count == 3 {
                self.pwImgInterface.setImage(UIImage(named: "pw3"))
            }
            else {
                self.pwImgInterface.setImage(UIImage(named: "pw4"))
            }
        }
    }
    var isClickable: Bool = true
    
    //MARK: lifeCycle
    
    override func awake(withContext context: Any?) {
        initUI()
    }
       
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("willActivate")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        print("didDeactivate")
    }
    
    //MARK: func
    
    func initUI() {
        self.number1btn.setTitle("1")
        self.number2btn.setTitle("2")
        self.number3btn.setTitle("3")
        self.number4btn.setTitle("4")
        self.number5btn.setTitle("5")
        self.number6btn.setTitle("6")
        self.number7btn.setTitle("7")
        self.number8btn.setTitle("8")
        self.number9btn.setTitle("9")
        self.number0btn.setTitle("0")
        self.backspaceBtn.setTitle("🔙")
        self.pwImgInterface.setImage(UIImage(named: "pw0"))
    }
    
    func numberClicked(number:PWInterfaceControllerNumberPadEnum) {
        if self.isClickable {
            switch number {
            case .zero:
                self.inputPW += "0"
                clickAnimation(button: self.number0btn, group: self.group4, complition: {
                    
                })
                break
            case .one:
                self.inputPW += "1"
                clickAnimation(button: self.number1btn, group: self.group1, complition: {
                    
                })
                break
            case .two:
                self.inputPW += "2"
                clickAnimation(button: self.number2btn, group: self.group1, complition: {
                    
                })
                break
            case .three:
                self.inputPW += "3"
                clickAnimation(button: self.number3btn, group: self.group1, complition: {
                    
                })
                break
            case .four:
                self.inputPW += "4"
                clickAnimation(button: self.number4btn, group: self.group2, complition: {
                    
                })
                break
            case .five:
                self.inputPW += "5"
                clickAnimation(button: self.number5btn, group: self.group2, complition: {
                    
                })
                break
            case .six:
                self.inputPW += "6"
                clickAnimation(button: self.number6btn, group: self.group2, complition: {
                    
                })
                break
            case .seven:
                self.inputPW += "7"
                clickAnimation(button: self.number7btn, group: self.group3, complition: {
                    
                })
                break
            case .eight:
                self.inputPW += "8"
                clickAnimation(button: self.number8btn, group: self.group3, complition: {
                    
                })
                break
            case .nine:
                self.inputPW += "9"
                clickAnimation(button: self.number9btn, group: self.group3, complition: {
                    
                })
                break
            }
        }
    }
    
    func clickAnimation(button: WKInterfaceButton,group: WKInterfaceGroup, complition:@escaping () -> ()) {
        self.isClickable = false
        let animationTime: useconds_t = 2
        DispatchQueue.main.async { [weak self] in
            self?.animate(withDuration: 0.1 * Double(animationTime), animations: {
                button.setRelativeWidth(0.4, withAdjustment: 0)
                group.setRelativeHeight(0.3, withAdjustment: 0)
            })
            DispatchQueue.global().async { [weak self] in
                usleep(animationTime * 100 * 1000)
                DispatchQueue.main.async {
                    self?.animate(withDuration: 0.1 * Double(animationTime), animations: {
                        button.setRelativeWidth(0.33, withAdjustment: 0)
                        group.setRelativeHeight(0.25, withAdjustment: 0)
                        DispatchQueue.global().async {
                            usleep(animationTime * 100 * 1000)
                            DispatchQueue.main.async { [weak self] in
                                self?.isClickable = true
                                complition()
                            }
                        }
                    })
                }
            }
        }
    }
    
    //MARK: action
    @IBAction func clicked1Action() {
        numberClicked(number: .one)
    }
    
    @IBAction func clicked2Action() {
        numberClicked(number: .two)
    }
    
    @IBAction func clicked3Action() {
        numberClicked(number: .three)
    }
    
    @IBAction func clicked4Action() {
        numberClicked(number: .four)
    }
    
    @IBAction func clicked5Action() {
        numberClicked(number: .five)
    }
    
    @IBAction func clicked6Action() {
        numberClicked(number: .six)
    }
    
    @IBAction func clicked7Action() {
        numberClicked(number: .seven)
    }
    
    @IBAction func clicked8Action() {
        numberClicked(number: .eight)
    }
    
    @IBAction func clicked9Action() {
        numberClicked(number: .nine)
    }
    
    @IBAction func clicked0Action() {
        numberClicked(number: .zero)
    }
    
    @IBAction func clickedBackAction() {
        self.inputPW.removeLast()
    }
    
    
}
