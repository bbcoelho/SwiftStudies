//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Bruno Coelho on 24/11/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func calculate(_ value: Double, operation operator: String) -> Double? {
        
        switch `operator` {
            
        case "AC":
            return 0.0
        case "+/-":
            return value * -1
        case "%":
            return value / 100
        case "=":
            return performTwoNumCalculation(n2: value)
        default:
            intermediateCalculation = (n1: value, calcMethod: `operator`)
            return value
        }
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,
           let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        
        return nil
    }

}
