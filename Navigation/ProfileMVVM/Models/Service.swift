//
//  File.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import Foundation
import UIKit

class Service {
    
    private var users = [
        User(login: "misha", password: "123123", name: "Cat",
             status: "I AM SUPER CAT",
             avatarImage: UIImage(named: "cat"),
             photos: (1...20).map { UIImage(named: "\($0)")!}),
        User(login: "murmur", password: "12345", name: "Cat",
             status: "I AM SUPER CAT",
             avatarImage: UIImage(named: "cat"),
             photos: (1...20).map { UIImage(named: "\($0)")!}),
        User(login: "cat", password: "321", name: "Cat",
             status: "I AM SUPER CAT",
             avatarImage: UIImage(named: "cat"),
             photos: (1...20).map { UIImage(named: "\($0)")!})
        ]
    
    func fetchUser(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        // Имитирует запрос данных из сети (делая паузу в 1 секунду)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self else { return}
            // Главное
            var i = users.count
            for user in users {
                if user.login == login && user.password == password {
                    completion(.success(user))
                    break
                } else if i == 0 {
                    completion(.failure(CustomError.noUser))
                } else  {
                    i -= 1
                }
            }
        })
    }
        
}

enum CustomError {
    case noUser
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noUser: return "no such user"
        }
    }
}

