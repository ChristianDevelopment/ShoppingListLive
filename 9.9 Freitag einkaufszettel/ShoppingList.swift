//
//  Einkaufsliste.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 12.09.22.
//

import Foundation

struct ShoppingList {
    
    var headline : String
    
    var list : [Product]
    
}

struct Product {
    
    var name : String
    
    var pieces : String
    
    var check: Bool
    
}
