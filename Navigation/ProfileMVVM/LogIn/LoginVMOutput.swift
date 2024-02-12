//
//  LoginVMOutput.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import Foundation

protocol LoginVMOutput {
    var state: State { get set }
    var currentState: ((State) -> Void)? { get set }
    var coordinator: LogInScreenCoordinatorProtocol? {get}
    func changeState(login: String, password: String)
}

enum State {
    case initial
    case loading
    case logined(User)
    case error
}
