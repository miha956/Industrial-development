//
//  SingUpViewModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 12.03.2024.
//

import Foundation

final class SingUpViewModel: SingUpVMOutput {
    
    private let checkerService: CheckerServiceProtocol
    
    init(checkerService: CheckerServiceProtocol) {
        self.checkerService = checkerService
    }
    
    func checkConfirmPassword(password: String, confirmPassword: String, complition: (Bool) -> Void) {
        if password != confirmPassword {
            complition(false)
        } else {
            complition(true)
        }
    }
    
    func singUp(email: String, password: String, complition: @escaping (Bool) -> Void) {
        
        checkerService.signUp(email: email, password: password) { result in
            switch result {
            case .success(let data):
                print("we have a user")
                complition(true)
            case .failure(let error):
                complition(false)
                print("Ошибка получения данных \(error.localizedDescription)")
            }
        }
    }
}
