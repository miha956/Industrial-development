//
//  LoginFactory.swift
//  Navigation
//
//  Created by Миша Вашкевич on 24.01.2024.
//

import Foundation

protocol LoginFactory {
    
    func makeLoginInspector() -> LoginInspector
    
}
