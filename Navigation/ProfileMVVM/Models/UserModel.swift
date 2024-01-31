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

