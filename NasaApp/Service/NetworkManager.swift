//
//  NetworkManager.swift
//  NasaApp
//
//  Created by Анастасия Улитина on 09.12.2020.
//

import Foundation

enum NetworkError: Error {
        case noDataAvilable
        case canNotProcessData
        case notFound
    }

protocol Networking {
    func request(request: String, completion: @escaping(Result<[NasaItem], NetworkError>) -> Void)
}

class NetworkManager: Networking {
    
    let baseUrl = "https://images-api.nasa.gov/search?q="
    
    func request(request: String, completion: @escaping(Result<[NasaItem], NetworkError>) -> Void) {
        let requestedUrl = baseUrl + request
        guard let url = URL(string: requestedUrl) else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            // Check if there is a fetched data
            guard let jsonData = data else {
                completion(.failure(.noDataAvilable))
                return
            }
            // Check if there is a decoded data
            guard let decodedData = ResponseDecodable(data: jsonData).decode(NasaAPI.self) else {
                completion(.failure(.canNotProcessData))
                return
            }
            let nasaModel = decodedData.collection.items
            // Check if fetched collection is not nil
            if nasaModel as NSArray == [] {
                completion(.failure(.notFound))
            }
            // Pass fetched data
            completion(.success(nasaModel))
            //print(nasaModel)
        }
        dataTask.resume()

    }

}

