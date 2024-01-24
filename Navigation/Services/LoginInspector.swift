//
//  LoginInspector.swift
//  Navigation
//
//  Created by Миша Вашкевич on 23.01.2024.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate, UserService {
    
    
    let checker = Checker.shared
    let user = User.make()
    
    func check(login: String, password: String) -> Bool {
        checker.check(login: login, password: password)
    }
    
    func checkUser(login: String) -> User? {
        user.login == login ? user : nil
    }
}
