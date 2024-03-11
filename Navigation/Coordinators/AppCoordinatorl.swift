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
    
    var rootViewController: UIViewController = UIViewController() {
        didSet {
                self.window.rootViewController = self.rootViewController
    
        }
    }
    
    
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    private func setCurrentCoordinator(coordinator: BaseCoordinatorProtocol) {
        rootViewController = coordinator.rootViewController
    }
    
    func start() {
        let mainTableViewCoordinator = MainTableViewCoordinator()
        addChildCoordinator(coordinator: mainTableViewCoordinator)
        mainTableViewCoordinator.start()
        setCurrentCoordinator(coordinator: mainTableViewCoordinator)
    }

}
