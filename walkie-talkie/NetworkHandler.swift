//
//  NetworkHandler.swift
//  walkie-talkie
//
//  Created by Nika Elashvili on 10/2/21.
//

import Foundation

class NetworkHandler {
    
#if targetEnvironment(simulator)
    let server = "http://localhost:3000"
#else
    let server = ""
#endif
    
    /// Queries all "history" data from the Mock Backend.
    func queryHistory(completion: @escaping ([Message]?, Error?)->()) {
        guard let url  = URL(string: "\(server)/history") else {
            completion(nil, CustomError.incorrectURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            
            guard let data = data else {return}
            let decoder = JSONDecoder()

            do {
                let messages = try decoder.decode([Message].self, from: data)
                completion(messages, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
