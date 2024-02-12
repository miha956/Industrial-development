//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 05.02.2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private var window: UIWindow
    
    var rootViewController: UIViewController = UIViewController()
    
    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = start()
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Functions
    
    func start() -> UIViewController {
        let mainCoordinator = MainCoordinator()
        rootViewController = mainCoordinator.start()
        return rootViewController
    }
}
