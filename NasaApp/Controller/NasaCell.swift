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
    var nasaSpinner = UIActivityIndicatorView()
    var playImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        addSubview(nasaImage)
        addSubview(nasaLabel)
        addSubview(nasaSpinner)
        addSubview(playImage)
        
        configureLabel()
        configureImageView()
        configureSpinner()
        configurePlayImage()
        
        setImageConstraints()
        setLabelConstraints()
        setSpinnerConstraints()
        setPlayImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearImages() {
        nasaImage.image = nil
        playImage.isHidden = true
    }
    
    func configureImageView() {
        nasaImage.clipsToBounds = true
        nasaImage.backgroundColor = .clear
        nasaImage.contentMode = .scaleAspectFill
    }
    
    func configureLabel() {
        nasaLabel.numberOfLines = 0
        nasaLabel.adjustsFontSizeToFitWidth = true
        nasaLabel.textColor = .white
    }
    
    func configureSpinner() {
        nasaSpinner.startAnimating()
        nasaSpinner.style = .medium
    }
    
    func configurePlayImage() {
        playImage.image = UIImage(systemName: "play.fill" )
        playImage.isHidden = true
        playImage.tintColor = .white
        playImage.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        playImage.layer.cornerRadius = frame.height / 5
        playImage.contentMode = .scaleAspectFit
        playImage.isHidden = true
    }

    func setImageConstraints() {
        nasaImage.translatesAutoresizingMaskIntoConstraints = false
        nasaImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nasaImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        nasaImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nasaImage.widthAnchor.constraint(equalTo: nasaImage.heightAnchor).isActive = true
    }

    func setLabelConstraints() {
        nasaLabel.translatesAutoresizingMaskIntoConstraints = false
        nasaLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nasaLabel.leadingAnchor.constraint(equalTo: nasaImage.trailingAnchor, constant: 20).isActive = true
        nasaLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nasaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setSpinnerConstraints() {
        nasaSpinner.translatesAutoresizingMaskIntoConstraints = false
        nasaSpinner.centerYAnchor.constraint(equalTo: nasaImage.centerYAnchor).isActive = true
        nasaSpinner.centerXAnchor.constraint(equalTo: nasaImage.centerXAnchor).isActive = true
        nasaSpinner.heightAnchor.constraint(equalToConstant: 10).isActive = true
        nasaSpinner.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    func setPlayImageConstraints() {
        playImage.translatesAutoresizingMaskIntoConstraints = false
        playImage.centerYAnchor.constraint(equalTo: nasaImage.centerYAnchor).isActive = true
        playImage.centerXAnchor.constraint(equalTo: nasaImage.centerXAnchor).isActive = true
        playImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
