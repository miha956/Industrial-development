//
//  LogInViewModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import Foundation

final class LogInViewModel: LoginVMOutput {
    
    private let service: Service
    var currentState: ((UserLogInState) -> Void)?
    
    var userLoinState: UserLogInState = .initial {
        didSet {
            currentState?(userLoinState)
        }
    }
    
    func changeState(login: String, password: String) {
        userLoinState = .loading
        service.fetchUser(login: login, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let user):
                    userLoinState = .logined(user)
                case .failure(let error):
                userLoinState = .error(error)
            }
        }
    }
    
    init(service: Service) {
        self.service = service
    }
    
}
