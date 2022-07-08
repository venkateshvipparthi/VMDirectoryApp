//
//  MockNetworkManager.swift
//  StaffsDirectoryTests
//
//  Created by Admin on 08/07/2022.
//

import Foundation
@testable import VMDirectoryAPP

class MockNetworkManager: Networkble {
    func get<T>(_ baseUrl: String, path: String, type: T.Type, completionHandler: @escaping (Result<[T], APIError>) -> Void) where T : Decodable {
        
        
        let bundle = Bundle(for:MockNetworkManager.self)
        
        guard let url = bundle.url(forResource:path, withExtension:"json"),
              let data = try? Data(contentsOf: url) else {
                  completionHandler(.failure(APIError.serviceNotAvailable))
                  
                  return
              }
        
        do {
            let decodedResopnce = try JSONDecoder().decode([T].self, from: data)
            completionHandler(.success(decodedResopnce))
            
        }catch {
            completionHandler(.failure(APIError.parsingFailed))
        }
        
    }
}

