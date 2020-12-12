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
    
    let baseUrl = "https://images-api.nasa.gov/search?media_type=image&q="
    
    
    func request(request: String = "nebula", completion: @escaping(Result<[NasaItem], NetworkError>) -> Void) {
        let requestedUrl = baseUrl + request
        print(requestedUrl)
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
            guard let nasaModel = self.parseJSON(jsonData) else {
                completion(.failure(.canNotProcessData))
                return
            }
            if nasaModel as NSArray == [] {
                completion(.failure(.notFound))
            }
            completion(.success(nasaModel))
        }
        dataTask.resume()

    }
    
    func parseJSON(_ nasaData: Data) -> [NasaItem]? {
        
        //let nasaArray = [Nasa]()
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NasaAPI.self, from: nasaData)
            if decodedData.collection.metadata.total_hits != 0 {
                //print(decodedData)
                return decodedData.collection.items
            } else {
                return []
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    

}

