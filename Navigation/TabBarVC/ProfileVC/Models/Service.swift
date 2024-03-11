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
        User(login: "misha", password: "123a", name: "Cat",
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
    
    func fetchUser(login: String, password: String, completion: @escaping (Result<User, CustomError>) -> Void) {
        // Имитирует запрос данных из сети (делая паузу в 1 секунду)
        // тут применили Result
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self = self else {
                preconditionFailure("self must be")
            }
            var i = 0
            for user in users {
                i += 1
                if user.login == login && user.password == password {
                    completion(.success(user))
                    break
                } else if i == users.count {
                    completion(.failure(CustomError.noUser))
                }
            }
        })
    }
        
}

enum CustomError: Error {
    case noUser
    
    var description: String  {
        switch self {
        case .noUser:
            return "No such user"
        }
    }
}



