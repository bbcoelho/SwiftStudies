//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, rate: CoinModel, currency: String)
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "90E2654B-CC66-4FA2-B620-B023AE702ABA"
    
    var delegate: CoinManagerDelegate?
    
    func getCoinRate(for currency: String) {
        
        let coinURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        //1. Create a URL
        if let url = URL(string: coinURL) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let rate = self.parseJSON(data: safeData) {
                        self.delegate?.didUpdateRate(self, rate: rate, currency: currency)
                    }
                }
                
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let coinData = CoinModel(rate: decodedData.rate)
            return coinData
        } catch {
            self.delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}
