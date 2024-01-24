//
//  TabViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        setTabBarAppearance()
    }
    
    private func setTabBar() {
        
        let loginVC = LogInViewController()
        loginVC.loginDelegate = LoginInspector()
        
        let navigationController = UINavigationController(rootViewController: FeedViewController())
        let navigationController2 = UINavigationController(rootViewController: loginVC)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowColor = UIColor(red: 60/255, green: 60/255, blue: 0/255, alpha: 0.29)
        navBarAppearance.backgroundColor = UIColor.white.withAlphaComponent(1)
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController2.navigationBar.scrollEdgeAppearance = navBarAppearance

        
        self.viewControllers = [
            setVC(
                viewController: navigationController,
                title: "Привычки",
                image: UIImage(systemName: "house.fill")),
            setVC(
                viewController: navigationController2,
                title: "Profile",
                image: UIImage(systemName: "person.fill"))
        ]
    }
    
    private func setVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    
    private func setTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tabBarAppearance.shadowColor = UIColor(red: 60/255, green: 60/255, blue: 0/255, alpha: 0.29)
        tabBar.scrollEdgeAppearance = tabBarAppearance

    }
}

