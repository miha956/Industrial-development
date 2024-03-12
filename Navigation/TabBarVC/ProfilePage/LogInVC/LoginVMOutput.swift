//
//  LoginVMOutput.swift
//  Navigation
//
//  Created by Миша Вашкевич on 31.01.2024.
//

import Foundation
import UIKit

protocol LoginVMOutput {
    var userLoinState: UserLogInState { get set }
    var currentState: ((UserLogInState) -> Void)? { get set }
    func changeState(login: String, password: String)
    
    func loginButtonEnabled(email: String, password: String, logInButton: UIButton)

}

enum UserLogInState {
    case initial
    case loading
    case logined(User)
    case error(Error)
}

