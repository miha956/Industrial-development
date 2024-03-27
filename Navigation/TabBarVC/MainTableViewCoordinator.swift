//
//  MainTableViewCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 10.03.2024.
//

import Foundation
import UIKit


protocol MainTableViewCoordinatorProtocol: BaseCoordinatorProtocol {
    //some flow
}

class MainTableViewCoordinator: MainTableViewCoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    
        let tabBarViewController = MainTabBarViewController()
        tabBarViewController.mainTableViewCoordinator = self
        let feedNavigationController = UINavigationController()
        feedNavigationController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        let feedCoordinator = FeedPageCoordinator(navigationController: feedNavigationController)
        childCoordinators.append(feedCoordinator)
        feedCoordinator.start()
        
        let profilePageNavigationController = UINavigationController()
        profilePageNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        let profilePageCoordinator = ProfilePageCoordinator(navigationController: profilePageNavigationController)
        childCoordinators.append(profilePageCoordinator)
        profilePageCoordinator.start()
        
        let coreDataManafer = CoreDataManager()
        let favoritPageNavigationController = UINavigationController(rootViewController: FavoritPostsViewController(coreDataManager: coreDataManafer))
        favoritPageNavigationController.tabBarItem = UITabBarItem(title: "FavorPosts", image: UIImage(systemName: "bookmark"), tag: 2)
        
        tabBarViewController.viewControllers = [
            feedNavigationController,
            profilePageNavigationController,
            favoritPageNavigationController
            ]

        navigationController.pushViewController(tabBarViewController, animated: true)
    }
    
    deinit {
        print("MainTableViewCoordinator deinit")
    }
}
