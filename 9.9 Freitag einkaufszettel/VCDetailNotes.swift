//
//  VCDetailNotes.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 12.09.22.
//
import UIKit

protocol EditProductDelegate {
    func editProduct (cell : CellProduct)
}

class CellProduct : UITableViewCell {
    
    var editProductDelegate : EditProductDelegate?
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBAction func buttonEdit(_ sender: UIButton) {
        editProductDelegate?.editProduct(cell: self)
    }
}


class VCDetailNotes: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var list0: [Product]?
    var list1: [Product]?
    
    var shoppingList : ShoppingList! {
        didSet{
            reloadSectionLists()
        }
    }
    
    var indexOfShoppingList : Int!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func trash(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(
            title: "Löschen", message: "Möchtest du die Liste wirklich löschen?", preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel , handler: nil))
        alert.addAction(UIAlertAction(title: "Bestätigen", style: .default , handler: {_ in
            
            
            for product in self.shoppingList.list?.allObjects as! [Product] {
                self.context.delete(product)
            }
            self.context.delete(self.shoppingList)
            
            
            do {
                try self.context.save()
            }
            catch {
                print ("FEHLER: Konnte die Liste nicht entfernen")
            }
            self.navigationController?.popViewController(animated: true)
                }
            )
        )
        present (alert,animated: true)
    }
    
    
    @IBAction func addProduct(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(
            title: "Hinzufügen", message: "Bitte Trage deinen Text ein !", preferredStyle: .alert
        )
        
        alert.addTextField { field in
            field.placeholder = "Text"
            field.returnKeyType = .continue
        }
        alert.addTextField { field in
            field.placeholder = "Menge"
            field.returnKeyType = .continue
        }
        alert.addTextField { field in
            field.placeholder = "Maßeinheit"
            field.returnKeyType = .continue
        }
        
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel , handler: nil))
        alert.addAction(UIAlertAction(title: "Hinzufügen", style: .default , handler: {_ in
            
            guard let textFields = alert.textFields else { return }
            
            let nameTextField = textFields[0]
            let titel = nameTextField.text
            
            let amountTextField = textFields[1]
            let amount = Float(amountTextField.text ?? "0")
            
            let typeTextField = textFields[2]
            let type = typeTextField.text
            
            let newProduct = Product (context: self.context)
            newProduct.name = titel
            newProduct.amount = amount ?? 0
            newProduct.check = false
            newProduct.type = type
            newProduct.shoppinglist = self.shoppingList
            
            do {
                try self.context.save()
            }
            catch {
                print ("FEHLER: konnte das neue Produkt nicht speichern")
            }
            
            self.reloadSectionLists()
            self.tableView.reloadData()
        }))
        
        present (alert,animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = CAGradientLayer()
        
        color.frame = view.bounds
        color.colors = [UIColor.systemCyan.cgColor, UIColor.cyan.cgColor,UIColor.systemGreen.cgColor]
        
        
        color.startPoint = CGPoint( x: 0.0 , y: 0.5 ) ;
        color.endPoint = CGPoint ( x: 1.0 , y: 0.5 ) ;
        view.layer.insertSublayer ( color, at: 0 )
        
        
        
        
        self.title = shoppingList.headline
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func reloadSectionLists(){
        
        var list0tmp: [Product] = []
        var list1tmp: [Product] = []
        
        for product in shoppingList.list?.allObjects as! [Product] {
            if product.check == false {
                list0tmp.append(product)
            }
            if product.check == true {
                list1tmp.append(product)
            }
        }
        
        list0 = list0tmp
        list1 = list1tmp
    }
}


extension VCDetailNotes : EditProductDelegate {
    
    func editProduct(cell: CellProduct) {
        
        if let indexPath = tableView.indexPath(for: cell){
            
            var product: Product!
            if indexPath.section == 0 {
                product = list0![indexPath.row]
            }
            else {
                product = list1![indexPath.row]
            }
            
            let alert = UIAlertController(
                title: "Bearbeiten", message: "Bitte bearbeite deinen Text !", preferredStyle: .alert
            )
            
            alert.addTextField { field in
                field.placeholder = product.name
                field.returnKeyType = .continue
            }
            alert.addTextField { field in
                field.placeholder = product.amount.description
                field.returnKeyType = .continue
            }
            alert.addTextField { field in
                field.placeholder = product.type
                field.returnKeyType = .continue
            }
            
            alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel , handler: nil))
            alert.addAction(UIAlertAction(title: "Speichern", style: .default , handler: {_ in
                
                guard let fields = alert.textFields else { return }
                
                let nameTextField = fields[0]
                let titel = nameTextField.text
                
                let amountTextField = fields[1]
                let amount = amountTextField.text
                
                let typeTextField = fields[2]
                let type = typeTextField.text
                
                if titel != "" {
                    product.name = titel
                }
                if amount != "" {
                    product.amount = Float(amount ?? "") ?? 0
                }
                if type != "" {
                    product.type = type
                }
                
                do {
                    try self.context.save()
                }
                catch{
                    print ("FEHLER: Konnte Änderungen nicht speichern")
                }
                
                self.reloadSectionLists()
                self.tableView.reloadData()
            }))
            
            present (alert,animated: true)
        }
    }
}

extension VCDetailNotes : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return list0?.count ?? 0
        }
        else {
            return list1?.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }
        else {
            if list1?.isEmpty ?? true {
                return ""
            }
            else {
                return "Erledigt"
            }
        }
    }
    
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell (withIdentifier: "ProductCell", for: indexPath) as! CellProduct
        
        cell.editProductDelegate = self
        
        if indexPath.section == 0 {
            
            let product = list0![indexPath.row]
            
            cell.amount.attributedText = nil
            if product.amount > 0 {
                cell.amount.text = product.amount.description
            }
            else {
                cell.amount.text = ""
            }
            
            cell.productLabel.attributedText = nil
            cell.productLabel.text = product.name
            
            cell.typeLabel.attributedText = nil
            cell.typeLabel.text = product.type
        }
        else {
            let product = list1![indexPath.row]
            
            // AMOUNT
            if product.amount > 0 {
                let amountString: NSMutableAttributedString = NSMutableAttributedString(string: product.amount.description)
                amountString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: amountString.length))
                cell.amount.attributedText = amountString
            }
            else {
                let amountString: NSMutableAttributedString = NSMutableAttributedString(string: "")
                amountString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: amountString.length))
                cell.amount.attributedText = amountString
            }
            
            // NAME
            let nameString: NSMutableAttributedString = NSMutableAttributedString(string:product.name!)
            nameString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: nameString.length))
            cell.productLabel.attributedText = nameString
            
            // TYPE
            let typeString: NSMutableAttributedString = NSMutableAttributedString(string:product.type!)
            typeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: typeString.length))
            cell.typeLabel.attributedText = typeString
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            list0![indexPath.row].check = true
        }
        else {
            list1![indexPath.row].check = false
        }
        
        NotificationCenter.default.post(name:NSNotification.Name.init("de.shoppingList.update"),object: (shoppingList,indexOfShoppingList))
        
        reloadSectionLists()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            if indexPath.section == 0 {
                let productToRemove = list0![indexPath.row]
                context.delete(productToRemove)
            }
            else {
                let productToRemove = list1![indexPath.row]
                context.delete(productToRemove)
            }
            
            do {
                try self.context.save()
            }
            catch {
                print ("FEHLER: Konnte das Produkt nicht entfernen")
            }
            
            reloadSectionLists()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
