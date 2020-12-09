//
//  NasaCell.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 09.12.2020.
//

import UIKit

class NasaCell: UITableViewCell {
    
    var nasaImage = UIImageView()
    var nasaLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nasaImage)
        addSubview(nasaLabel)
        
        configureLabel()
        configureImageView()
        setImageConstraints()
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
//    func set() {
//        nasaLabel.text = "Nasa"
//        nasaImage.image = UIImage(systemName: "rain")
//    }
    
    
    func configureImageView() {
        nasaImage.clipsToBounds = true
        nasaImage.backgroundColor = .systemPink
    }
    
    func configureLabel() {
        nasaLabel.numberOfLines = 0
        nasaLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        nasaImage.translatesAutoresizingMaskIntoConstraints = false
        nasaImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nasaImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        nasaImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        nasaImage.widthAnchor.constraint(equalTo: nasaImage.heightAnchor).isActive = true
    }

    func setLabelConstraints() {
        nasaLabel.translatesAutoresizingMaskIntoConstraints = false
        nasaLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nasaLabel.leadingAnchor.constraint(equalTo: nasaImage.trailingAnchor, constant: 20).isActive = true
        nasaLabel.heightAnchor.constraint(equalToConstant: 180).isActive = true
        nasaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
}
