//
//  StringExt.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 14.12.2020.
//

import Foundation

extension String {
    
    var formatedForUrl: String {
        let string = self.replacingOccurrences(of: " ", with: "%20")
        return string
    }
    
}
