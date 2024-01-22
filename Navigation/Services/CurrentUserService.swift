//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Миша Вашкевич on 17.01.2024.
//

import Foundation

final class CurrentUserService: UserService {
    
    private let user: User
    
    func checkUser(login: String) -> User? {
        if user.name == login {
            return user
        }
        return nil
    }
    
    init(user: User) {
        self.user = user
    }
}
