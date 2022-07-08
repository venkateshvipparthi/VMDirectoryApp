//
//  APIError.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import Foundation

enum APIError: Error {
    case serviceNotAvailable
    case parsingFailed
    case requestNotFormatted
}
