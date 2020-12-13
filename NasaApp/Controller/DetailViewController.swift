//
//  ViewController.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 09.12.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private var imageNasa: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var textDescription: UITextView = {
        let textv = UITextView()
        textv.isEditable = false
        textv.isScrollEnabled = true
        textv.backgroundColor = .black
        textv.textColor = .white
        textv.font = .systemFont(ofSize: 16)
        textv.textAlignment = .justified
        return textv
    }()
    
    private var playButton: UIButton = {
        let bttn = UIButton()
        bttn.setImage(UIImage(systemName: "play"), for: .normal)
        bttn.tintColor = .white
        bttn.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return bttn
    }()
    
    var nasaModel: NasaModel? {
        didSet{
           updateInterface()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(label)
        view.addSubview(imageNasa)
        view.addSubview(textDescription)
        view.addSubview(playButton)
        setLabelLayout()
        setImageLayout()
        setDesriptionLayout()
        setButtonLayout()
        playButton.addTarget(self, action: #selector(buttonPressed(_: )), for: .touchUpInside)
    }
    
    private func updateInterface() {
        //Update title
        label.text = nasaModel?.title
        //Update image
        
        ImageLoader.sharedLoader.imageForUrl(urlString: nasaModel!.imageURL) { (image, string) in
            self.imageNasa.image = image
        }
        //Update description
        textDescription.text = nasaModel?.description
        // Play button
        if nasaModel?.mediaType == "image" {
            playButton.isHidden = true
            playButton.isEnabled = false
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        print("button pressed")
    }
    

    private func setImageLayout() {
        imageNasa.translatesAutoresizingMaskIntoConstraints = false
        imageNasa.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageNasa.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageNasa.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageNasa.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
    }
    
    private func setLabelLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageNasa.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setDesriptionLayout() {
        textDescription.translatesAutoresizingMaskIntoConstraints = false
        textDescription.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        textDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    private func setButtonLayout() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerYAnchor.constraint(equalTo: imageNasa.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: imageNasa.centerXAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    
    
    

}


