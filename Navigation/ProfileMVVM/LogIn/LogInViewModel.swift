//
//  LogInViewModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import Foundation

final class LogInViewModel: LoginVMOutput {
    
    private let service: Service
    private let brutForsePassword: BrutForsePassword
    
    var userLoinState: UserLogInState = .initial {
        didSet {
            print(userLoinState)
            currentState?(userLoinState)
        }
    }
    
    var brutForsePasswordState: BrutForsePasswordState = .initial {
        didSet {
            print(brutForsePasswordState)
            brutForseResult?(brutForsePasswordState)
        }
    }
    
    var currentState: ((UserLogInState) -> Void)?
    var brutForseResult: ((BrutForsePasswordState) ->Void)?
    
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
    
    func brutForse(passwordToUnlock: String) {
        brutForsePasswordState = .loading
            self.brutForsePassword.fetchPassword(passwordToUnlock: passwordToUnlock) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let password):
                    brutForsePasswordState = .fetched(password)
                case .failure(_):
                    break
            }
        }
    }
    
    init(service: Service, brutForsePassword: BrutForsePassword) {
        self.service = service
        self.brutForsePassword = brutForsePassword
    }
    
}
