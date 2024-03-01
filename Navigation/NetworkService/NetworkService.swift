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
    
    static func requestTitle(completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/todos/1"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                guard let title = json!["title"] as? String else { return }
                completion(.success(title))
            } catch let (jsonError){
                print("json error \(jsonError.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    static func fetchPlanet(completion: @escaping (Result<Planet, Error>) -> Void) {
        let urlString = "https://swapi.dev/api/planets/1"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            
            do {
                let planet = try JSONDecoder().decode(Planet.self, from: data)
                completion(.success(planet))
            } catch let (jsonError){
                print("json error \(jsonError.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
}
