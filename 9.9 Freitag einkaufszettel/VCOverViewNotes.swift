//
//  ViewController.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 09.09.22.
//

import UIKit


class VCOverViewNotes: UIViewController {
    
    var data : [ ShoppingList ] = [ ]
    
    var selectetList : ShoppingList?
    var listIndex2 : Int!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func addList(_ sender: UIBarButtonItem) {

            let alert = UIAlertController(
                title: "Titel", message: "Bitte Trage deinen Titel ein !", preferredStyle: .alert
            )
            
            alert.addTextField { field in
                field.placeholder = "Titel"
                field.returnKeyType = .continue
            }
            
            alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel , handler: nil))
            alert.addAction(UIAlertAction(title: "Hinzufügen", style: .default , handler: {_ in
                
                guard let fields = alert.textFields, fields.count == 1 else {
                    return
                }
                
                let titels = fields[0]
                guard let titel = titels.text else {
                    print ("Invalid entries")
                    return
                }
                
                let newList = ShoppingList(context: self.context)
                     newList.headline = titel
                
             //   let newList = ShoppingList (
              //      headline: titel,
                //    list : [                        ])
                
                self.data.insert(newList, at: 0)
                do{
                    try self.context.save()
                }
                catch{
                    print ("data fehler")
                }
                
                self.collectionView.reloadData()
                
            }
                                          
       ))
            present (alert,animated: true)
    }
    
    
    // var screenSize: CGRect!
    //  var screenWidth: CGFloat!
    //  var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
           collectionView.dataSource = self
        
        //  screenSize = UIScreen.main.bounds
        //      screenWidth = screenSize.width
        //     screenHeight = screenSize.height
        
        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //      layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        //      layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        //       layout.minimumInteritemSpacing = 0
        //      layout.minimumLineSpacing = 0
        //      collectionView!.collectionViewLayout = layout
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateList), name: NSNotification.Name.init("de.shoppingList.update"), object: nil)
        fetchLists()
        
    }
    
    func fetchLists(){
        do {
            self.data =
            try self.context.fetch(ShoppingList.fetchRequest())
        }
        catch{
            print ("dataFetch fehler")
        }
    }
    
    @objc func updateList (notification:NSNotification) {
        
        let newShoppingListWithIndex = notification.object as! (ShoppingList,Int)
        
        data[newShoppingListWithIndex.1] = newShoppingListWithIndex.0
    }
}

extension VCOverViewNotes : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCell", for: indexPath) as! CollectionViewCell
        
        cell.label.text = data[indexPath.row].headline
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectetList = data [indexPath.row]
        listIndex2 = indexPath.row
        performSegue(withIdentifier: "NaviVCDetailNotes", sender: nil)
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? VCDetailNotes {
            destinationVC.detailList = selectetList
            destinationVC.listIndex = listIndex2
        }
    }
}



