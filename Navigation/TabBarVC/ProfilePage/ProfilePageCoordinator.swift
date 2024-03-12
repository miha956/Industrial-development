//
//  ProfilePageCoordinatorProtocol.swift
//  Navigation
//
//  Created by Миша Вашкевич on 11.03.2024.
//

import Foundation
import UIKit
import FirebaseAuth

protocol ProfilePageCoordinatorProtocol: BaseCoordinatorProtocol {
    //some flow
}

final class ProfilePageCoordinator: ProfilePageCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
  
    func start() {
        if Auth.auth().currentUser != nil {
            let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
            addChildCoordinator(coordinator: profileCoordinator)
            profileCoordinator.start()
        } else {
            let logInCoordinator = LogInCoordinator(navigationController: navigationController)
            addChildCoordinator(coordinator: logInCoordinator)
            logInCoordinator.start()
        }
    }  
}
