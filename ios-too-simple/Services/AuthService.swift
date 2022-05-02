//
//  AuthService.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 4/8/22.
//

import Foundation

struct LoginResponse: Codable {
    let bearerToken: String?
    let status: Int?
    let success: Bool?
    let errorMessage: String?
}

class AuthService {
    
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse, Error>) -> Void) {
            guard let url = URL(string: "https://api.brandonlempka.com/api/Auth/login") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: AnyHashable] = [
                "username": username,
                "password": password
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data, error == nil else {
                    print (error)
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    //let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    print(response)
                    completion(.success(response))
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
}
