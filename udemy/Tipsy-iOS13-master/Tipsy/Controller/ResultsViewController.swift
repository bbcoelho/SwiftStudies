//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Bruno Coelho on 30/09/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var splitValue: String?
    var splitNumber: Int?
    var tipPercentage: Double?

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let splitValueText = splitValue, let tipPercentageText = tipPercentage, let splitNumberText = splitNumber {
            
            totalLabel.text = splitValueText
            settingsLabel.text = "Split between \(splitNumberText) people, with \(Int(tipPercentageText * 100))% tip."
        }

    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
