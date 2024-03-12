//
//  LogInViewModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import Foundation

final class LogInViewModel: LoginVMOutput {
    
    private let checkerService: CheckerServiceProtocol
    
    var currentState: ((UserLogInState) -> Void)?
    var userLoinState: UserLogInState = .initial {
        didSet {
            currentState?(userLoinState)
        }
    }
    init(checkerService: CheckerServiceProtocol) {
        self.checkerService = checkerService
    }
    
    func changeState(login: String, password: String) {
        userLoinState = .loading
        checkerService.checkCredentials(email: login, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.userLoinState = .logined(user)
            case .failure(let error):
                self.userLoinState = .error(error)
            }
        }
    }
    
    func checkUserCreditails(login: String, password: String) {
        // checkUserCreditails
    }
    
}
