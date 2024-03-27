//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 11.03.2024.
//

import Foundation
import UIKit

protocol ProfileCoordinatorProtocol: BaseCoordinatorProtocol {
    
    func presentUserPhotos()
}

final class ProfileCoordinator: ProfileCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let user = Service().users[0]
        let coreDataManager = CoreDataManager()
        let profileVc = ProfileViewController(currenyUser: user, coreDataManager: coreDataManager)
        navigationController.setViewControllers([profileVc], animated: true)
    }
    
    func presentUserPhotos() {
        // presentUserPhotos
    }
    
    deinit {
        print("ProfileCoordinatorProtocol deinit")
    }
}
