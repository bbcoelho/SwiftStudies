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
    
    // HABILITA O BOTAO DE RETORNO DO TECLADO PARA SAIR DA EDICAO DOS CAMPOS
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // HABILITA A SAIDA DE EDICAO DOS CAMPOS CLICANDO EM QUALQUER LUGAR DA VIEW
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
