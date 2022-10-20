//
//  VC_NotesCell.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 20.10.22.
//

import UIKit

class VC_NotesCell: UICollectionViewCell {
    
    var cornerRadius: CGFloat = 15.0
    
    
    override func awakeFromNib() {
        
         super.awakeFromNib()
             
         // Apply rounded corners to contentView
         contentView.layer.cornerRadius = cornerRadius
         contentView.layer.masksToBounds = true
         
         // Set masks to bounds to false to avoid the shadow
         // from being clipped to the corner radius
         layer.cornerRadius = cornerRadius
         layer.masksToBounds = false
         
         // Apply a shadow
         layer.shadowRadius = 7.0
         layer.shadowOpacity = 0.50
         layer.shadowColor = UIColor.black.cgColor
         layer.shadowOffset = CGSize(width: 5, height: 5)
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.5
    
     }
}
