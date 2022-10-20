//
//  VC_OverViewNotes.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 20.10.22.
//

import UIKit

class VC_OverViewNotes: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = CAGradientLayer()
        
        color.frame = view.bounds
        color.colors = [UIColor.systemGreen.cgColor, UIColor.cyan.cgColor,UIColor.systemCyan.cgColor]
        
        color.startPoint = CGPoint( x: 0.0 , y: 0.5 ) ;
        color.endPoint = CGPoint ( x: 1.0 , y: 0.5 ) ;
        view.layer.insertSublayer ( color, at: 0 )

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
