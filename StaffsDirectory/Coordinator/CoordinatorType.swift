//
//  CoordinatorType.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import Foundation
import UIKit

protocol CoordinatorType: AnyObject {
    var navController: UINavigationController { get set }
    func start()
}
