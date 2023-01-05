//
//  MainView.swift
//  WhatFlower
//
//  Created by Bruno Coelho on 08/12/22.
//

import UIKit

class MainView: UIView {
    
    lazy var flowerImage: UIImageView = {
        
        let image = UIImageView()
        
        image.backgroundColor = .systemGreen
        image.tintColor = .white
        image.image = UIImage(systemName: "arrow.up.forward")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var flowerDescription: UILabel = {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.text = "CLICK ON CAMERA ICON AND TAKE A PHOTO OF YOUR FLOWER FOR SEARCH!"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemGreen
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        addSubview(flowerImage)
        NSLayoutConstraint.activate([
            flowerImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            flowerImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            flowerImage.widthAnchor.constraint(equalToConstant: 200),
            flowerImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        addSubview(flowerDescription)
        NSLayoutConstraint.activate([
            flowerDescription.topAnchor.constraint(equalTo: flowerImage.bottomAnchor, constant: 50),
            flowerDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            flowerDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            flowerDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
