//
//  DetailVC_Config+Ext.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 14.12.2020.
//

import Foundation

extension DetailViewController {
    
    func setImageLayout() {
        imageNasa.translatesAutoresizingMaskIntoConstraints = false
        imageNasa.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageNasa.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageNasa.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageNasa.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
    }
    
    func setLabelLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageNasa.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setDesriptionLayout() {
        textDescription.translatesAutoresizingMaskIntoConstraints = false
        textDescription.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        textDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func setButtonLayout() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerYAnchor.constraint(equalTo: imageNasa.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: imageNasa.centerXAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
