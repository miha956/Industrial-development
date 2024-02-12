//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 06.02.2024.
//

import UIKit

enum UserFlow {
    case logIn
    case profile
}

final class MainCoordinator: MainCoordinatorProtocol {

    var rootViewController: UIViewController = TabViewController()
    
    var feedCoordinator: FeedScreenCoordinatorProtocol = FeedCoordinator()
    var profileCoordinator: ProfileScreenCoordinatorProtocol = ProfileCoordinator()
    
    func moveTo(flow: UserFlow) {
        let profileViewController = profileCoordinator.start()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        (rootViewController as? UITabBarController)?.viewControllers![1] = profileViewController
    }
    
    func start() -> UIViewController {
        
        profileCoordinator.parentCoordinator = self
        
        let feedViewController = feedCoordinator.start()
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
                
        let profileViewController = profileCoordinator.start()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
                
                (rootViewController as? UITabBarController)?.viewControllers = [feedViewController,profileViewController]
        
        return rootViewController
    }
 
}
