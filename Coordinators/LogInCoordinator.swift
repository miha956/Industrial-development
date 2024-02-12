//
//  LogInCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 06.02.2024.
//

import UIKit

final class LogInCoordinator: LogInScreenCoordinatorProtocol {
    
    var parentCoordinator: ProfileCoordinator?
    
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let service = Service()
        let modelView = LogInViewModel(service: service, coordinator: self)
        rootViewController = LogInViewControllerMVVM(viewModel: modelView)
        
        return rootViewController
    }
    
    func logInUser() {
        parentCoordinator?.logInStateProvider.changeLoinState()
        parentCoordinator?.parentCoordinator?.moveTo(flow: .profile)

    }
    
    init(parentCoordinator: ProfileCoordinator) {
        self.parentCoordinator = parentCoordinator
    }
}
