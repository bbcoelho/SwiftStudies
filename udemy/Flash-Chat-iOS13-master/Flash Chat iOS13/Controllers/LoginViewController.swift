//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        tryAuthenticate()
    }
    
    func tryAuthenticate() {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authDataResutl, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    // Navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == emailTextfield {
                passwordTextfield.becomeFirstResponder()
            } else {
                tryAuthenticate()
            }
        return false // We do not want UITextField to insert line-breaks.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
