//
//  TipsyBrain.swift
//  Tipsy
//
//  Created by Bruno Coelho on 02/10/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

struct TipsyBrain {
    
    var billValue: Double
    var tipPercentage: Double
    var splitNumber: Double
    
    func getSplitResult() -> String {
        
        let splitValue = billValue * (1 + tipPercentage) / splitNumber
        let splitResult = String(format: "%.2f", splitValue)
        
        return splitResult
    }
}
