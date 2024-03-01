//
//  TitleModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 01.03.2024.
//

import Foundation

struct NewTitle: Decodable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

typealias NewTitleLabel = [NewTitle]
