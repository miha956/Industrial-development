//
//  LoginVMOutput.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import Foundation

protocol LoginVMOutput {
    var userLoinState: UserLogInState { get set }
    var currentState: ((UserLogInState) -> Void)? { get set }
    var brutForseResult: ((BrutForsePasswordState) ->Void)? { get set }
    func changeState(login: String, password: String)
    func brutForse(passwordToUnlock: String)
}

enum UserLogInState {
    case initial
    case loading
    case logined(User)
    case error(CustomError)
}

enum BrutForsePasswordState {
    case initial
    case loading
    case fetched(String)
    case error
}
