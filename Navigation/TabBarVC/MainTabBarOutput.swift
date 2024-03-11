//
//  MainTabBarOutput.swift
//  Navigation
//
//  Created by Миша Вашкевич on 11.03.2024.
//

import Foundation

protocol MainTabBarOutput {
    
    var userIsLogined: Bool { get set }
    
    func fetchUser()
}
