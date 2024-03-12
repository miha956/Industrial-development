//
//  TabViewController.swift
//  Navigation
//
//  Created by Миша Вашкевич on 28.11.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    weak var mainTableViewCoordinator: MainTableViewCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTabBarAppearance()
    }
    private func setupView() {
        self.tabBarController?.selectedIndex = 1
        // it doesn't work why??
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

