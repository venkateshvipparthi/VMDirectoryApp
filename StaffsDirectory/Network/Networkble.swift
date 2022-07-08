//
//  Networkble.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import Foundation

protocol Networkble {
    func get<T:Decodable>(_ baseUrl:String, path:String, type:T.Type, completionHandler:@escaping(Result<[T],   APIError>)->Void)
}
