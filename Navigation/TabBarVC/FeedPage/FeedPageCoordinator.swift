//
//  FeedViewCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 11.03.2024.
//

import Foundation
import UIKit

protocol FeedPageCoordinatorProtocol: BaseCoordinatorProtocol {}

final class FeedPageCoordinator: FeedPageCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FeedViewController()
        vc.feedViewCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
