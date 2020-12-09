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
    }

protocol Networking {
    func request(urlString: String, completion: @escaping(Result<[NasaData], NetworkError>) -> Void)
}

class NetworkManager: Networking {
    

    func request(urlString: String, completion: @escaping(Result<[NasaData], NetworkError>) -> Void) {
        print("request")
        guard let url = URL(string: urlString) else { return }
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
            guard let nasaModel = self.parseJSON(jsonData) else {
                completion(.failure(.canNotProcessData))
                return
            }
            completion(.success(nasaModel))
        }
        dataTask.resume()

    }
    
    func parseJSON(_ nasaData: Data) -> [NasaData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NasaModel.self, from: nasaData)
            let result = decodedData.collection?.items
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

