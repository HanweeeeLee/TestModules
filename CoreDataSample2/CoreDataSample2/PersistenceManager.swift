//
//  PresistenceManager.swift
//  CoreDataSample2
//
//  Created by hanwe lee on 2021/04/05.
//

import UIKit
import CoreData

class PersistenceManager {
    static var shared: PersistenceManager = PersistenceManager()
    
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

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
    
    //fetch
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print("error:\(error.localizedDescription)")
            return []
        }
    }
//    let request: NSFetchRequest<Contact> = Contact.fetchRequest()
//    let fetchResult = PersistenceManager.shared.fetch(request: self.request)
    
    //insert
    @discardableResult func insertPerson(person: Person) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: self.context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(person.name, forKey: "name")
            managedObject.setValue(person.phoneNumber, forKey: "phoneNumber")
            managedObject.setValue(person.shortcutNumber, forKey: "shortcutNumber")
            
            do {
                try self.context.save()
                return true
            } catch {
                print("error:\(error.localizedDescription)")
                return false
            }
            
        } else {
            return false
        }
    }
//    let walker = Person(name: "Walker", phoneNumber: "010-1234-5678", shortcutNumber: 2)
//    PersistenceManager.shared.insertPerson(person: walker)
    
    //delete object
    @discardableResult func delete(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    //    let request: NSFetchRequest<Contact> = Contact.fetchRequest()
    //    let fetchResult = PersistenceManager.shared.fetch(request: self.request)
    //    PersistenceManager.shared.delete(object: fetchResult.last!)
    
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int? {
        do {
            let count = try self.context.count(for: request)
            return count
        } catch {
            return nil
        }
    }
    
    @discardableResult
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(delete)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
