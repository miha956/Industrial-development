//
//  BaseCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 10.03.2024.
//

import Foundation
import UIKit

protocol BaseCoordinatorProtocol: CoordinatorProtocol {
    
    var rootViewController: UIViewController { get set }
}

