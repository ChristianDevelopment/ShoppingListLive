//
//  VCDetailNotiz.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 12.09.22.
//

import UIKit

class CellProduct : UITableViewCell {
    
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBAction func buttonEdit(_ sender: UIButton) {
    
    }
}

class VCDetailNotes: UIViewController {
    
    var detailList : ShoppingList!
    
    var listIndex : Int!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addProduct(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(
            title: "Text", message: "Bitte Trage deinen Text ein !", preferredStyle: .alert
        )
        
        alert.addTextField { field in
            field.placeholder = "Text"
            field.returnKeyType = .continue
        }
        alert.addTextField { field in
            field.placeholder = "Menge"
            field.returnKeyType = .continue
        }
        
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel , handler: nil))
        alert.addAction(UIAlertAction(title: "Hinzufügen", style: .default , handler: {_ in
            
            guard let fields = alert.textFields, fields.count == 2 else {
                return
            }
            
            let nameField = fields[0]
            guard let titel = nameField.text
            else {
                print ("Invalid entries")
                return
            }
            
            let amountField = fields[1]
            guard let amount = amountField.text
            else {
                print ("Invalid entries")
                return
            }
            
            let newProduct = Product (
                name: titel ,
                pieces: amount,
                check: false
                )
            
            
            self.detailList.list.insert(newProduct, at: 0)
            
            self.tableView.reloadData()
            
        }
                                      
                                     ))
        present (alert,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = detailList.headline
        tableView.dataSource = self
        tableView.delegate = self
    }
}





extension VCDetailNotes : UITableViewDataSource,UITableViewDelegate {
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detailList.list.count
        
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = self.detailList.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell (withIdentifier: "ProductCell", for: indexPath) as! CellProduct
        
        cell.amount.text = product.pieces
        
        cell.productLabel.text = product.name
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailList.list[indexPath.row].check = true
        
        NotificationCenter.default.post(name:NSNotification.Name.init("de.shoppingList.update"),object: (detailList,listIndex))
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            detailList.list.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
}
