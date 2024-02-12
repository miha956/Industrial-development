//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 06.02.2024.
//

import Foundation
import UIKit

final class ProfileCoordinator: ProfileScreenCoordinatorProtocol {
    
    var parentCoordinator: MainCoordinatorProtocol?
    
    var rootViewController: UIViewController = UIViewController()
    let logInStateProvider = LogInStateProvider()
    
    
    func start() -> UIViewController {
        if logInStateProvider.state {
            let userPlofileCoordinator = UserPlofileCoordinator()
            rootViewController = userPlofileCoordinator.start()
        } else {
            let loginCoordinator = LogInCoordinator(parentCoordinator: self)
            rootViewController = loginCoordinator.start()
        }
        return rootViewController
    }
}
