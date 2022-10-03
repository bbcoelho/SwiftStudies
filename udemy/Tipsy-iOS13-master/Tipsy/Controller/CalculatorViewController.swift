//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Bruno Coelho on 30/09/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipsyBrain = TipsyBrain(billValue: 0.00, tipPercentage: 0.1, splitNumber: 2.0)

    @IBAction func tipChanged(_ sender: UIButton) {
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        billTextField.endEditing(true)
        
        let selectedTip = sender.currentTitle
        
        if selectedTip == "0%" {
            tipsyBrain.tipPercentage = 0.0
        }
        if selectedTip == "10%" {
            tipsyBrain.tipPercentage = 0.1
        }
        if selectedTip == "20%" {
            tipsyBrain.tipPercentage = 0.2
        }
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        tipsyBrain.splitNumber = sender.value
        splitNumberLabel.text = String(Int(tipsyBrain.splitNumber))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        
        if bill != "" {
            tipsyBrain.billValue = Double(bill) ?? 0.0
        }
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.splitValue = tipsyBrain.getSplitResult()
            destinationVC.splitNumber = Int(tipsyBrain.splitNumber)
            destinationVC.tipPercentage = tipsyBrain.tipPercentage
            
        }
    }
    
}
