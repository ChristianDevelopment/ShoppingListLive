//
//  VC_Regis.swift
//  9.9 Freitag einkaufszettel
//
//  Created by Christian Eichfeld on 21.10.22.
//

import UIKit
import Firebase


class VC_Regis: UIViewController {
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var EMailConfirm: UITextField!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var PasswordConfirm: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBAction func ButtonRegis(_ sender: UIButton) {
        
    
        if EmailTextField.text == EMailConfirm.text {
            
            if PasswordField.text == PasswordConfirm.text{
                
                Auth.auth().createUser(withEmail: EmailTextField.text!, password: PasswordField.text!) { authResult, error in
                
                }
                performSegue(withIdentifier: "RegisToTab", sender: nil)
                            }
            else {
                 ErrorLabel.text = "Bitte Passwort eingabe Überprüfen !"
            }
        }
        else { ErrorLabel.text = "Bitte E-mail eingabe Überprüfen !"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
