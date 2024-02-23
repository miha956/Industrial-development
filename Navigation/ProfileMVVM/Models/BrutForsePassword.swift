//
//  BrutForsePassword.swift
//  Navigation
//
//  Created by Миша Вашкевич on 22.02.2024.
//

import Foundation

class BrutForsePassword {
    
    let queue = DispatchQueue(label: "someQueueFast", qos: .userInteractive)
    
        func indexOf(character: Character, _ array: [String]) -> Int {
            return array.firstIndex(of: String(character))!
        }
        
        func characterAt(index: Int, _ array: [String]) -> Character {
            return index < array.count ? Character(array[index])
            : Character("")
        }
        
        func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
            var str: String = string
                if str.count <= 0 {
                    str.append(self.characterAt(index: 0, array))
                }
                else {
                    
                    str.replace(at: str.count - 1,
                                with: self.characterAt(index: (self.indexOf(character: str.last!, array) + 1) % array.count, array))
                    
                    if self.indexOf(character: str.last!, array) == 0 {
                        str = String(self.generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
                    }
                }
                return str
        }
    
    func fetchPassword(passwordToUnlock: String, completion: @escaping (Result<String, Error>) -> Void) {
            let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
            var password: String = ""
            while password != passwordToUnlock {
                password = self.generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            }
            
            completion( .success(password))
            print(password)
        }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
