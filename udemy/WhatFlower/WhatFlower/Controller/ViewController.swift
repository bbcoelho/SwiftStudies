//
//  ViewController.swift
//  WhatFlower
//
//  Created by Bruno Coelho on 08/12/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    private let imagePicker = UIImagePickerController()
    
    private let mainView = MainView()
    
    private let dataServices = DataServices()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        
        title = "What Flower?"
        
        dataServices.delegate = self
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .camera, target: self, action: #selector(self.cameraTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }

    @objc func cameraTapped() {
        
        present(imagePicker, animated: true)
    }
}

//MARK: - ImagePickerController Delegates
extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Model failed to process image.")
            }
            
            let flowerLabel = dataServices.detectFlower(image: ciImage).capitalized

            navigationItem.title = flowerLabel
            
            dataServices.fetchData()
        }
        
        mainView.flowerDescription.text = ""
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - DataServices Delegate
extension ViewController: DataServicesDelegate {
    func didUpdateInfo(_ dataServices: DataServices, flowerDescription: String, flowerImageURL: String) {
        
        mainView.flowerDescription.text = flowerDescription
        mainView.flowerImage.sd_setImage(with: URL(string: flowerImageURL))
    }
    
    func didFailWithError(_ dataServices: DataServices, error: Error) {
        
        print(error)
    }
    
    
}

