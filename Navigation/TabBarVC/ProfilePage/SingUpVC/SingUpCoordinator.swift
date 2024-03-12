//
//  SingUpCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 12.03.2024.
//

import Foundation
import UIKit

    protocol SingUpCoordinatorProtocol: BaseCoordinatorProtocol {
    
    func singUpAndLogin()
}

    final class SingUpCoordinator: SingUpCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let checkerService = CheckerService()
        let singUpMoodel = SingUpViewModel(checkerService: checkerService)
        let singUpViewController = SingUpViewController(singUpViewModel: singUpMoodel)
        singUpViewController.singUpCoordinator = self
        navigationController.pushViewController(singUpViewController, animated: true)
    }

    func singUpAndLogin() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        addChildCoordinator(coordinator: profileCoordinator)
        profileCoordinator.start()   
    }
        
    deinit {
        print("SingUpCoordinatorProtocol deinit")
    }
}
