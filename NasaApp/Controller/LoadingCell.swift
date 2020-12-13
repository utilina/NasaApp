//
//  LoadingCell.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 13.12.2020.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    var loadingSpinner = UIActivityIndicatorView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadingSpinner.startAnimating()
        
        addSubview(loadingSpinner)
        setSpinnerConstraints()
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSpinnerConstraints() {
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingSpinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingSpinner.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loadingSpinner.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
}
