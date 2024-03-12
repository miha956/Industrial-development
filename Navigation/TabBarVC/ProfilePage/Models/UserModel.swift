//
//  UserModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 13.12.2023.
//

import Foundation
import UIKit

public struct User {
    let login: String
    let password: String
    let name: String
    let status: String?
    let avatarImage: UIImage?
    let photos: [UIImage]
}

extension User {
    
    static func make() -> User {
        User(login: "misha", password: "12345", name: "Cat",
             status: "I AM SUPER CAT",
             avatarImage: UIImage(named: "cat"),
             photos: (1...20).map { UIImage(named: "\($0)")!})
    }
}

