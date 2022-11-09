//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Bruno Coelho on 31/10/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    
    static let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
