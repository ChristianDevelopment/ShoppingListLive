//
//  VCOverViewNotes.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 09.09.22.
//
import UIKit

class VCOverViewNotes: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var allLists : [ShoppingList]?
    
    var selectedList : ShoppingList?
    var indexOfSelectedList : Int!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(
            title: "Hinzufügen", message: "Bitte trage einen Listennamen ein!", preferredStyle: .alert
        )
        
        alert.addTextField { field in
            field.placeholder = "Listenname"
            field.returnKeyType = .continue
        }
        
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel , handler: nil))
        alert.addAction(UIAlertAction(title: "Hinzufügen", style: .default , handler: {_ in
            
            guard let textFields = alert.textFields else { return }
            
            let nameTextField = textFields[0]
            
            let newList = ShoppingList(context: self.context)
            newList.headline = nameTextField.text
            
            self.allLists?.insert(newList, at: 0)
            
            do {
                try self.context.save()
            }
            catch {
                print ("FEHLER: konnte neue Liste nicht speichern")
            }
            
            self.collectionView.reloadData()
        }))
        
        present (alert,animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchLists()
        
        collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let color = CAGradientLayer()
        
        color.frame = view.bounds
        color.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor,UIColor.red.cgColor]

        //[UIColor.init(red: 98, green: 130, blue: 178, alpha: 1).cgColor,
        //UIColor.init(red: 138, green: 180, blue: 247, alpha: 1).cgColor,
        //UIColor.init(red: 98, green: 130, blue: 178, alpha: 1).cgColor]
        
        color.startPoint = CGPoint( x: 0.0 , y: 0.5 ) ;
        color.endPoint = CGPoint ( x: 1.0 , y: 0.5 ) ;
        view.layer.insertSublayer ( color, at: 0 )
        
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateShoppingList), name: NSNotification.Name.init("de.shoppingList.update"), object: nil)
        
        fetchLists()
        
    }
    
    
    @objc func updateShoppingList (notification: NSNotification) {
        let shoppingListWithIndex = notification.object as! (ShoppingList,Int)
        let shoppingList = shoppingListWithIndex.0
        let indexOfList = shoppingListWithIndex.1
        allLists?[indexOfList] = shoppingList
    }
    
    
    func fetchLists(){
        do {
            self.allLists = try self.context.fetch(ShoppingList.fetchRequest())
        }
        catch{
            print ("FEHLER: konnte die Shopping Listen nicht abrufen")
        }
    }
}


extension VCOverViewNotes : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCell", for: indexPath) as! CollectionViewCell
        cell.label.text = allLists?[indexPath.row].headline
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLists?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedList = allLists? [indexPath.row]
        indexOfSelectedList = indexPath.row
        performSegue(withIdentifier: "NaviVCDetailNotes", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? VCDetailNotes {
            destinationVC.shoppingList = selectedList
            destinationVC.indexOfShoppingList = indexOfSelectedList
        }
    }
}
