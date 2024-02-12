//
//  LogInViewModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import Foundation

final class LogInViewModel: LoginVMOutput {
    
    var coordinator: LogInScreenCoordinatorProtocol?
    
    private let service: Service
    var state: State = .initial {
        didSet {
            print(state)
            currentState?(state)
        }
    }
    
    var currentState: ((State) -> Void)?
    
    func changeState(login: String, password: String) {
        state = .loading
        service.fetchUser(login: login, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let user):
                    state = .logined(user)
                case .failure(_):
                    state = .error
            }
        }
    }
    
    init(service: Service, coordinator: LogInScreenCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
    }
    
}
