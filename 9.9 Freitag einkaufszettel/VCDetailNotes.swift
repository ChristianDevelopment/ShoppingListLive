//
//  VCDetailNotiz.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 12.09.22.
//

import UIKit

class VCDetailNotes: UIViewController {

    var detailList : ShoppingList!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        let cell = tableView.dequeueReusableCell (withIdentifier: "ProductCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = detailList.list[indexPath.row].name
        
        
        if detailList.list[indexPath.row].check == true{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else{
            cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        cell.contentConfiguration = content
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailList.list[indexPath.row].check = true
        
        tableView.reloadData()
    }
}
