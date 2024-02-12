//
//  UserPlofileCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 12.02.2024.
//

import UIKit

class UserPlofileCoordinator: UserProfileScreenCoordinatorProtocol {
    
    var parentCoordinator: Coordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        rootViewController = UINavigationController(rootViewController:ProfileViewController(currenyUser: User(login: "misha", password: "123123", name: "Cat",
                                                                     status: "I AM SUPER CAT",
                                                                     avatarImage: UIImage(named: "cat"),
                                                                     photos: (1...20).map { UIImage(named: "\($0)")!}), coordinator: self))
        
        return rootViewController
    }
    
    func showUserPhoto() {
        let vc = PhotosViewController()
        navigationRootViewController?.pushViewController(vc, animated: true)
    }

}
