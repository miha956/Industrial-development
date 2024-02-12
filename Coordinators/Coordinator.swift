//
//  Coordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 05.02.2024.
//

import UIKit

typealias Action = (() -> Void)

public protocol Coordinator {
    
    var rootViewController: UIViewController { get set }
    
    @discardableResult func moveToRoot() -> Self
    
    func start() -> UIViewController
    
}

extension Coordinator {
    
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func moveToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
}


// Протокол для tabBar
protocol MainCoordinatorProtocol: Coordinator {
    var feedCoordinator: FeedScreenCoordinatorProtocol {get}
    var profileCoordinator: ProfileScreenCoordinatorProtocol {get}
    func moveTo(flow: UserFlow)
}
// Протокол для экрана feed
protocol FeedScreenCoordinatorProtocol: Coordinator {
    // нет переходов
}

// Протокол для экрана login
protocol LogInScreenCoordinatorProtocol: Coordinator {
    // логируемся и показываем profile
    func logInUser()
}
// Протокол для экрана Profile
protocol ProfileScreenCoordinatorProtocol: Coordinator {
    // логируемся и показываем profile
    var parentCoordinator: MainCoordinatorProtocol? {get set}
}

// Протокол для экрана User
protocol UserProfileScreenCoordinatorProtocol: Coordinator, FlowCoordinator {
    // логируемся и показываем profile
    func showUserPhoto()
}


