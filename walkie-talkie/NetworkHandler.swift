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
    let server = "http://192.168.1.50:3000"
#endif
    
    /// This function queries all "history" data from the Mock Backend.
    /// - Parameter userID: Is set to nil because we don't use it in this version
    func queryHistory(_ userID: String? = nil, completion: @escaping ([Message]?, Error?)->()) {
       // guard let userID = userID else { return }
       // guard let url  = URL(string: "\(server)/history/\(userID)") else {return}
        guard let url  = URL(string: "\(server)/history") else {
            completion(nil, CustomError.incorrectURL)
            return
        }
        
        // background task to make request with URLSession
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
        // start the task
        task.resume()
    }
}
