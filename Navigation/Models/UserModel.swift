//
//  UserModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 13.12.2023.
//

import Foundation
import UIKit

public struct User {
    let name: String
    let status: String?
    let avatarImage: UIImage?
    let photos: [UIImage?]
}

extension User {
    
    static func make() -> User {
        User(name: "Super cat",
             status: nil,
             avatarImage: UIImage(named: "cat"),
             photos: [
                UIImage(named: "1"),
                UIImage(named: "2"),
                UIImage(named: "3"),
                UIImage(named: "4"),
                UIImage(named: "5"),
                UIImage(named: "6"),
                UIImage(named: "7"),
                UIImage(named: "8"),
                UIImage(named: "9"),
                UIImage(named: "10"),
                UIImage(named: "11"),
                UIImage(named: "12"),
                UIImage(named: "13"),
                UIImage(named: "14"),
                UIImage(named: "15"),
                UIImage(named: "16"),
                UIImage(named: "17"),
                UIImage(named: "18"),
                UIImage(named: "19"),
                UIImage(named: "20")
             ])
    }
}
