//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 10.03.2024.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol: BaseCoordinatorProtocol {
    
    var window: UIWindow { get set }
}

class AppCoordinator: AppCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    var window: UIWindow
    
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        // set appereance navigationController
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let mainTableViewCoordinator = MainTableViewCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator: mainTableViewCoordinator)
        mainTableViewCoordinator.start()
    }

}
