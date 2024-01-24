//
//  UserService.swift
//  Navigation
//
//  Created by Миша Вашкевич on 17.01.2024.
//

import Foundation

protocol UserService {

    func checkUser(login: String) -> User?
    
}
