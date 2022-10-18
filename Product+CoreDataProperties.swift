//
//  Product+CoreDataProperties.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 17.10.22.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var amount: Float
    @NSManaged public var check: Bool
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var shoppinglist: ShoppingList?

}

extension Product : Identifiable {

}
