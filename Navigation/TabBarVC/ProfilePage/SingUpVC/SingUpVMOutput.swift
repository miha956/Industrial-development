//
//  SingUpVMOutput.swift
//  Navigation
//
//  Created by Миша Вашкевич on 12.03.2024.
//

import Foundation

protocol SingUpVMOutput {
    
    func checkConfirmPassword(password: String, confirmPassword: String, complition: (Bool) -> Void)
    func singUp(email: String, password: String, complition: @escaping(Bool) -> Void)
    
}
