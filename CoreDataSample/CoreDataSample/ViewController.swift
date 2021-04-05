//
//  ViewController.swift
//  CoreDataSample
//
//  Created by hanwe lee on 2021/04/05.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let hanwe = Person(name: "hanwe", phoneNumber: "010-3005-7935", shortcutNumber: 1)
        
        let context = self.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context) {
            let person = NSManagedObject(entity: entity, insertInto: context)
            person.setValue(hanwe.name, forKey: "name")
            person.setValue(hanwe.phoneNumber, forKey: "phoneNumber")
            person.setValue(hanwe.shortcutNumber, forKey: "shortcutNumber")
            
            do {
                try context.save()
            } catch {
                print("error:\(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    @IBAction func fetchContact(_ sender: Any) {
        let context = self.persistentContainer.viewContext
        
        do {
            let contact = try context.fetch(Contact.fetchRequest()) as! [Contact]
            contact.forEach {
                print($0.name)
            }
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
    
}

struct Person {
    var name: String
    var phoneNumber: String
    var shortcutNumber: Int
}


