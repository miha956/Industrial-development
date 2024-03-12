//
//  UserNetworkService.swift
//  Navigation
//
//  Created by Миша Вашкевич on 11.03.2024.
//

import Foundation
import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    
    var user = User(login: "misha", password: "123a", name: "Cat",
                     status: "I AM SUPER CAT",
                     avatarImage: UIImage(named: "cat"),
                     photos: (1...20).map { UIImage(named: "\($0)")!})
    
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            
            if let error = error {
                    completion(.failure(error))
                    print(error.localizedDescription)
            }
            guard let authDataResult = authDataResult else { return }
                completion(.success(self.user))
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                    completion(.failure(error))
                    print(error.localizedDescription)
            }
            guard let authResult = authResult else { return }
                completion(.success(authResult))
        }
    }
    
    deinit {
        print("CheckerService deinit")
    }
}
