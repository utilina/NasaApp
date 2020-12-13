//
//  ResponseDecodable.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 12.12.2020.
//

import Foundation

import Foundation

struct ResponseDecodable {
    
    fileprivate var data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    public func decode<T: Decodable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch _ {
            return nil
        }
    }
}
