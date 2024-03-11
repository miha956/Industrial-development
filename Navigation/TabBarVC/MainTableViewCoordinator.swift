//
//  MainTableViewCoordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 10.03.2024.
//

import Foundation
import UIKit

//enum AppFlow {
//    case profileView
//    case logInView
//}
//
//protocol MainBaseCoordinator: BaseCoordinatorProtocol {
//    //var feedCoordinator: FeedCoordinatorProtocol { get }
//    //var profileCoordinator: ProfileCoordinatorProtocol { get }
//    func moveTo(flow: AppFlow)
//}


class MainTableViewCoordinator: BaseCoordinatorProtocol {
    
    var rootViewController: UIViewController = UIViewController()
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    func start() {
        let tabViewController = TabBarViewController()
        tabViewController.mainTableViewCoordinator = self
        rootViewController = tabViewController
    }
}
