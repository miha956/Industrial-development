//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Миша Вашкевич on 23.01.2024.
//

import Foundation

protocol LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool
    
}
