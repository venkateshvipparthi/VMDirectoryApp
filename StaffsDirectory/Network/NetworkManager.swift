//
//  NetworkManager.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import Foundation

class NetworkManager: Networkble {
    func get<T>(_ baseUrl: String, path: String, type: T.Type, completionHandler: @escaping (Result<[T], APIError>) -> Void) where T : Decodable {
      
        let urlSession = URLSession.shared
        guard let url = URL(string:baseUrl.appending(path)) else {
            completionHandler(.failure(APIError.requestNotFormatted))
            return
        }
        let dataTask = urlSession.dataTask(with: url) { data, urlResponse, error in
            
            guard let _data = data else {
                completionHandler(.failure(APIError.serviceNotAvailable))
                return
            }
            do {
                let users =  try JSONDecoder().decode([T].self, from: _data)
                completionHandler(.success(users))
            }catch {
                completionHandler(.failure(APIError.parsingFailed))
            }
        }
        dataTask.resume()
    }
    
}
