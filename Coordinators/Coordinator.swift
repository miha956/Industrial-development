//
//  Coordinator.swift
//  Navigation
//
//  Created by Миша Вашкевич on 05.02.2024.
//

import Foundation

public protocol Coordinator {
    
    func start()
    
}

// Протокол для экрана feed
protocol ListScreen: AnyObject {
    var coordinator: Coordinator? { get set }
}

// Протокол для экрана login
protocol ListScreen: AnyObject {
    var coordinator: Coordinator? { get set }
}
