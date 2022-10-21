//
//  VC_LogIn.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 21.10.22.
//

import UIKit
import Firebase


class VC_LogIn: UIViewController {

    @IBOutlet weak var EMailLog: UITextField!
    @IBOutlet weak var PasswordLog: UITextField!
    
    @IBOutlet weak var ErrorLabelLog: UILabel!
    @IBAction func ButtonLogin(_ sender: UIButton) {
        
        if EMailLog.text != ""{
            
            if PasswordLog.text != ""{
                Auth.auth().signIn(withEmail: self.EMailLog.text!, password: PasswordLog.text!) { [weak self] authResult, error in
                        guard let strongSelf = self else { return }        }
                performSegue(withIdentifier: "LogInTOTabbar", sender: nil)

            } else {
                ErrorLabelLog.text = "Bitte Trage deine Daten korrekt ein !"

            }
        } else {
            ErrorLabelLog.text = "Bitte Trage deine Daten korrekt ein !"
        }
        
        
        }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
