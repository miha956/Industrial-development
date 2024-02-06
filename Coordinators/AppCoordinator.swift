//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 05.02.2024.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    
    private(set) var rootViewController: UIViewController = TabViewController() {
        didSet {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.window.rootViewController = self.rootViewController
            })
        }
    }
    
    let window: UIWindow
    
    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
        self.window.backgroundColor = .white
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
        
    }
}
