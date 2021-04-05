//
//  Contact+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by hanwe lee on 2021/04/05.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var shortcutNumber: Int16

}

extension Contact : Identifiable {

}
