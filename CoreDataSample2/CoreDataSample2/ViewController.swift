//
//  ViewController.swift
//  CoreDataSample2
//
//  Created by hanwe lee on 2021/04/05.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fetch(_ sender: Any) {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(request: request)
    }
    
    @IBAction func insert(_ sender: Any) {
        let walker = Person(name: "Walker", phoneNumber: "010-1234-5678", shortcutNumber: 2)
        PersistenceManager.shared.insertPerson(person: walker)
    }
    
    @IBAction func deleteObj(_ sender: Any) {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(request: request)
        PersistenceManager.shared.delete(object: fetchResult.last!)
    }
    
    @IBAction func count(_ sender: Any) {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        print(PersistenceManager.shared.count(request: request))
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        PersistenceManager.shared.deleteAll(request: request)
        let arr = PersistenceManager.shared.fetch(request: request)
        if arr.isEmpty {
            print("clean") // Print "clean"
        }
    }
    
}

