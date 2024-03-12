//
//  LogInCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 11.03.2024.
//

import Foundation

import Foundation
import UIKit

protocol LogInCoordinatorProtocol: BaseCoordinatorProtocol {
    
    func singUp()
    func logIn()
    
}

final class LogInCoordinator: LogInCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let checkerService = CheckerService()
        let logInViewModel = LogInViewModel(checkerService: checkerService)
        let logInViewController = LogInViewController(viewModel: logInViewModel)
        logInViewController.logInCoordinator = self
        navigationController.pushViewController(logInViewController, animated: true)
    }
    func logIn() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator: profileCoordinator)
        profileCoordinator.start()
    }
    func singUp() {
        let singUpCoordinator = SingUpCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator: singUpCoordinator)
        singUpCoordinator.start()
    }
    
    deinit {
        print("LogInCoordinator deinit")
    }
}
