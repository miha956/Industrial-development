//
//  Coordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 09.03.2024.
//

import Foundation

protocol CoordinatorProtocol: AnyObject {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    func start()
    
}

extension CoordinatorProtocol {
        
    func addChildCoordinator(coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
