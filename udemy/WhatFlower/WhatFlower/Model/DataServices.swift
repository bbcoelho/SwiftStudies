//
//  DataService.swift
//  WhatFlower
//
//  Created by Bruno Coelho on 20/12/22.
//

import UIKit

import CoreML
import Vision

import Alamofire
import SwiftyJSON

protocol DataServicesDelegate {
    func didUpdateInfo(_ dataServices: DataServices, flowerDescription: String, flowerImageURL: String)
    func didFailWithError(_ dataServices: DataServices, error: Error)
}

class DataServices {
    
    var flowerLabel: String = ""
    var flowerDescription: String = ""
    var flowerImageURL: String = ""
    
    var delegate: DataServicesDelegate?
    
    func detectFlower(image: CIImage) -> String {
        
        guard let model = try? VNCoreMLModel(for: FlowerImageClassifier103().model) else {
            fatalError("Loading CoreML model failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            
            if let title = results.first?.identifier, let accuracy = results.first?.confidence {
                
                if let label = LabelsJSON.labelCodes[title] {
                    
                    self.flowerLabel = label
                    print("DETECTION ACCURACY: \(accuracy)%")
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
        
        return flowerLabel
    }
    
    func fetchData() {
        
        let baseURL = "https://en.wikipedia.org/w/api.php"
        let parameters: [String : String] = [
            "action": "query",
            "format": "json",
            "prop": "extracts|pageimages",
            "exintro": "",
            "explaintext": "",
            "titles": flowerLabel,
            "indexpageids": "",
            "redirects": "1",
            "pithumbsize": "500"
        ]
        
        AF.request(baseURL, method: .get, parameters: parameters).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let data):
                
                let flowerJSON: JSON = JSON(data)
                
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                
                self.flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                self.flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                
                self.delegate?.didUpdateInfo(self, flowerDescription: self.flowerDescription, flowerImageURL: self.flowerImageURL)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
