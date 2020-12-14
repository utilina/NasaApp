//
//  ViewController.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 09.12.2020.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {
    
    var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var imageNasa: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var textDescription: UITextView = {
        let textv = UITextView()
        textv.isEditable = false
        textv.isScrollEnabled = true
        textv.backgroundColor = .black
        textv.textColor = .white
        textv.font = .systemFont(ofSize: 16)
        textv.textAlignment = .justified
        return textv
    }()
    
    var playButton: UIButton = {
        let bttn = UIButton()
        bttn.tintColor = .white
        bttn.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        bttn.layer.cornerRadius = 5
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "play.fill", withConfiguration: largeConfig)
        bttn.setImage(largeBoldDoc, for: .normal)
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
        // Adding subviews and constraints
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
        if nasaModel != nil {
            let nasaURL = nasaModel!.imageURL
            // Create video urlstring from image url
            let formatedURL = nasaURL.replacingOccurrences(of: " ", with: "%20")
            let videoURL = formatedURL.replacingOccurrences(of: "thumb.jpg", with: "orig.mp4")
            // Create url
            if let url = URL(string: videoURL) {
                // Create Video Player
                let video = AVPlayer(url: url)
                let videoPlayer = AVPlayerViewController()
                videoPlayer.player = video
                self.present(videoPlayer, animated: true, completion: {
                    video.play()
                })
            }
        }
    }
}


