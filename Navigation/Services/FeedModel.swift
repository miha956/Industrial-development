//
//  FeedModel.swift
//  Navigation
//
//  Created by Миша Вашкевич on 26.01.2024.
//

import Foundation

struct FeedModel {
    
    static let shared = FeedModel()
    let notificationCenter = NotificationCenter.default
    
    private let secretWord = "murmur"
    
    public func check(word: String) {
        if word == secretWord {
            notificationCenter.post(name: NSNotification.Name("wordIsCorrect"), object: nil)
        } else {
            notificationCenter.post(name: NSNotification.Name("wordIsWrong"), object: nil)
        }
    }
    private init() {}
}
