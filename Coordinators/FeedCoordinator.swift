//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 06.02.2024.
//

import Foundation
import UIKit

final class FeedCoordinator: FeedScreenCoordinatorProtocol {
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController: FeedViewController())
        return rootViewController
    }
    
    
}
