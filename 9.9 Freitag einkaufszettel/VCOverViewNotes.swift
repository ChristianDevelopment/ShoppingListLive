//
//  ViewController.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 09.09.22.
//

import UIKit

class VCOverViewNotes: UIViewController {
    
    var data : [ ShoppingList ]!
    
    var selectetList : ShoppingList?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if data == nil {
            data = [ ShoppingList (
                headline: "Party",
                list : [
                    Product ( name: "Cheese", pieces: 2, check: false ),
                    Product ( name: "Meat", pieces: 2, check: false )
                ]),
              
              ShoppingList (
                headline: "Shopping",
                list : [
                    Product ( name: "T-Shirt", pieces: 2, check: false ),
                    Product ( name: "Pancakes", pieces: 1, check: false ),
                    Product ( name: "Milk", pieces: 3, check: false ),
                    Product ( name: "Cola", pieces: 6, check: false )
                    ])
              ,
            
            ShoppingList (
              headline: "Test",
              list : [
                  Product ( name: "Shirt", pieces: 2, check: false ),
                  Product ( name: "Cake", pieces: 1, check: false ),
                  Product ( name: "Milk", pieces: 3, check: false ),
                  Product ( name: "Cola", pieces: 6, check: false )
                  ])
                ]
        }
    }
    
    
}

extension VCOverViewNotes : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCell", for: indexPath) as! CollectionViewCell
        
        cell.label.text = data[indexPath.row].headline
        
        print ("hello",data[indexPath.row].headline)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectetList = data [indexPath.row]
        performSegue(withIdentifier: "NaviVCDetailNotes", sender: nil)
//        print(data[indexPath.row].list)
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? VCDetailNotes {
            destinationVC.detailList = selectetList
        }
    }
}



