//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            guard let currentDisplayValue = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double")
            }
            return currentDisplayValue
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var calculatorLogic = CalculatorLogic()
    
    @IBOutlet private weak var displayLabel: UILabel!
    
    @IBAction private func numButtonPressed(_ sender: UIButton) {
        
        if let buttonNumber = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayLabel.text = buttonNumber
                isFinishedTypingNumber = false
            } else {
                
                if buttonNumber == "." {
                    
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                
                displayLabel.text = displayLabel.text! + buttonNumber
            }
        }
    }
    
    @IBAction private func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        if let calcMethod = sender.currentTitle {
            
            if let operationValue = calculatorLogic.calculate(displayValue, operation: calcMethod) {
                
                displayValue = operationValue
            }
        }
    }

}

