//
//  ShoppingList+CoreDataProperties.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 11.10.22.
//
//

import Foundation
import CoreData


extension ShoppingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingList> {
        return NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
    }

    @NSManaged public var headline: String?
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
extension ShoppingList {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: Product)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: Product)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}

extension ShoppingList : Identifiable {

}
