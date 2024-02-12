//
//  LogInStateProvider.swift
//  Navigation
//
//  Created by Миша Вашкевич on 06.02.2024.
//

import Foundation

private protocol LogInStateProviderProtocol {
    var state: Bool {get set}
    func changeLoinState()
}

final class LogInStateProvider: LogInStateProviderProtocol {
    
    var state = false
    
    func changeLoinState() {
        state = true
    }
    
}
