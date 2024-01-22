//
//  TestUserService.swift
//  Navigation
//
//  Created by Миша Вашкевич on 22.01.2024.
//

import Foundation

final class TestUserService: UserService {
    
    private let user: User
    
    func checkUser(login: String) -> User? {
        if login == "test" {
            return user
        }
        return nil
    }
    
    init(user: User) {
        self.user = user
    }
}
