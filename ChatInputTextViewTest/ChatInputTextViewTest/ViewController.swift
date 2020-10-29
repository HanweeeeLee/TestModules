//
//  ViewController.swift
//  ChatInputTextViewTest
//
//  Created by hanwe lee on 2020/10/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var myTextView: MyTestView!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var myTextViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var myTextViewBottomConstarint: NSLayoutConstraint!
    
    var originContainerViewHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
        self.myTextView.delegate = self
        self.myTextView.myDelegate = self
        self.originContainerViewHeight = self.containerViewHeightConstraint.constant
    }
        
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.containerViewBottomConstraint.constant = keyboardHeight
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.containerViewBottomConstraint.constant = 0
    }
    
}


extension ViewController: UITextViewDelegate, MyTestViewProtocol {
    func changeLine(view: MyTestView, line: UInt) {
        print("line:\(line)")
        self.containerViewHeightConstraint.constant = self.originContainerViewHeight +  "1".getSizeString(font: self.myTextView.font!).height * CGFloat(line)
    }
}

protocol MyTestViewProtocol: class {
    func changeLine(view: MyTestView, line: UInt)
}

class MyTestView: UITextView {
    
    var width:CGFloat = 0
    var currentEnterCnt:UInt = 0
    var defaultHeight:CGFloat = 0
    var overTextCnt:UInt = 0 {
        willSet {
            guard newValue != self.overTextCnt else {
                return
            }
        }
    }
    var totalLine:UInt = 0 {
        willSet {
            guard newValue != self.totalLine else {
                return
            }
            self.myDelegate?.changeLine(view: self, line: newValue)
        }
    }
    var accumulateValue:CGFloat = 0
    weak var myDelegate: MyTestViewProtocol?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeNotification), name: UITextView.textDidChangeNotification , object: nil)
        self.defaultHeight = self.text.getSizeString(font: self.font!).height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.textContainer.lineFragmentPadding = 0 //test
        self.width = self.frame.width - (self.textContainer.lineFragmentPadding * 2)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textDidChangeNotification(_ notif: Notification) {
        guard self == notif.object as? UITextView else {
            return
        }
        textDidChange()
    }
    
    func textDidChange() {
        let size: CGSize = self.text.getSizeString(font: self.font!)
        self.currentEnterCnt = UInt(size.height/defaultHeight) - 1
        let textArr: Array<String> = self.text.components(separatedBy: "\n")
        var overTextCnt:UInt = 0
        for i in 0..<textArr.count {
            let overLineCnt:UInt = getOverTextLine(text: textArr[i])
            overTextCnt += overLineCnt
        }
        self.overTextCnt = UInt(overTextCnt)
        self.totalLine = self.currentEnterCnt + self.overTextCnt
    }
    
    func getOverTextLine(text: String) -> UInt { //n^2
        var overLineCnt:UInt = 0
        var startIndex = text.index(text.startIndex, offsetBy: 0)
        for i in 0..<text.count {
            let checkIndex = text.index(text.startIndex, offsetBy: i)
            let checkValue = text[startIndex...checkIndex]
            let checkValueWidth: CGFloat = String(checkValue).getSizeString(font: self.font!).width
            if checkValueWidth/self.width > 1 {
                overLineCnt += 1
                startIndex = text.index(text.startIndex, offsetBy: i)
            }
        }
        return overLineCnt
    }
}

