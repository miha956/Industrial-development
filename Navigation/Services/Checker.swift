//
//  Checker.swift
//  Navigation
//
//  Created by Миша Вашкевич on 23.01.2024.
//

import Foundation

final class Checker {
    
    static let shared = Checker()

    // MARK: - Properties
    
     private let login: String = "misha"
     private let password: String = "123123"
    
    // MARK: - Lifecycle
    private init() {}
    
    
    // MARK: - Public func
    
    public func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password ? true : false
    }
}
