//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let coinModel = CoinModel(rate: 0.0)
    var coinManager = CoinManager()

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
    }
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinModel.currencyArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinModel.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinModel.currencyArray[row]
        coinManager.getCoinRate(for: selectedCurrency)
    }
}

extension ViewController: CoinManagerDelegate {
    
    func didUpdateRate(_ coinManager: CoinManager, rate: CoinModel, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = rate.rateString
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(_ coinManager: CoinManager, error: Error) {
        print(error)
    }
    
}
