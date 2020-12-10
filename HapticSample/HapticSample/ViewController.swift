//
//  ViewController.swift
//  HapticSample
//
//  Created by hanwe on 2020/12/10.
//

import UIKit

class ViewController: UIViewController {

    var feedbackGenerator: UINotificationFeedbackGenerator?
    
    var impactFeedbackGenerator: UIImpactFeedbackGenerator?
    
    var selectionFeedbackHenerator: UISelectionFeedbackGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setGenerator()
    }
    
    private func setGenerator() {
        self.feedbackGenerator = UINotificationFeedbackGenerator()
        self.feedbackGenerator?.prepare()
    }

    @IBAction func action1(_ sender: Any) {
        self.feedbackGenerator?.notificationOccurred(.success)
    }
    @IBAction func action2(_ sender: Any) {
        self.feedbackGenerator?.notificationOccurred(.warning)
    }
    @IBAction func action3(_ sender: Any) {
        self.feedbackGenerator?.notificationOccurred(.error)
    }
    @IBAction func action4(_ sender: Any) {
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    
    @IBAction func action5(_ sender: Any) {
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    
    @IBAction func action6(_ sender: Any) {
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    
    @IBAction func action7(_ sender: Any) {
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    
    @IBAction func action8(_ sender: Any) {
        self.impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
        self.impactFeedbackGenerator?.impactOccurred()
    }
    
    @IBAction func action9(_ sender: Any) {
        self.impactFeedbackGenerator?.impactOccurred()
    }
    
    @IBAction func actionA(_ sender: Any) {
        self.selectionFeedbackHenerator = UISelectionFeedbackGenerator()
        self.selectionFeedbackHenerator?.selectionChanged()
    }
}

