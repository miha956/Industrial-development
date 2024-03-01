//
//  NetworkService.swift
//  Navigation
//
//  Created by Миша Вашкевич on 01.03.2024.
//

import Foundation

enum AppConfiguration {
    case people(URL)
    case starships(URL)
    case planets(URL)
}

struct NetworkService {
    
    static func request(configuration: AppConfiguration) {
        
        let url: URL
        
        switch configuration {
            case .people(let path):
                url = path
            case .starships(let path):
                url = path
            case .planets(let path):
                url = path
            }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                print(error.localizedDescription.debugDescription)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("allHeaderFields :\(httpResponse.allHeaderFields)")
                print("statusCode \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print("json \(json)")
            } catch let (jsonError){
                print("json error \(jsonError.localizedDescription)")
            }
        }
        task.resume()
        
    }
    
}
