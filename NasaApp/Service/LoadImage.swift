//
//  LoadImage.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 10.12.2020.
//

import UIKit
import Foundation


class ImageLoader {
    
    let cache = NSCache<NSString, AnyObject>()
    
    func imageForUrl(urlString: String, completionHandler: @escaping (_ image: UIImage?, _ url: String) -> ()) {
        
        let formatedUrl = urlString.formatedForUrl
        
        DispatchQueue.global(qos: .background).async {
        
            let data: NSData? = self.cache.object(forKey: formatedUrl as NSString) as? NSData
            
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async {
                    completionHandler(image, formatedUrl)
                }
                return
            }
            guard let url = URL(string: formatedUrl) else { return }
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            session.dataTask(with: request) { data, response, error in
                
                if (error != nil) {
                    completionHandler(nil, formatedUrl)
                    return
                }
                
                if let data = data{
                    let image = UIImage(data: data)
                    self.cache.setObject(data as AnyObject, forKey: formatedUrl as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image, formatedUrl)
                    }
                }
            }.resume()
            
        }
       
    }
    // Create static
    class var sharedLoader : ImageLoader {
    struct Static {
        static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
}
