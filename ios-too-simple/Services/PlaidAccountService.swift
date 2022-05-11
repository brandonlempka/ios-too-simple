//
//  AccountService.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/11/22.
//

import Foundation

class PlaidAccountService {
    var plaidAccounts = PlaidAccountListResponse(plaidAccounts: [PlaidAccountResponse]())
    
    func getPlaidAccountsByUserId(
        userId: String,
        bearerToken: String,
        completion: @escaping (Result<PlaidAccountListResponse, Error>) -> Void) {
            guard let url = URL(string: "https://api.brandonlempka.com/api/PlaidAccounts/userId/\(userId)") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data, error == nil else {
                    print (error!)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    //let dateFormatter = DateFormatter()
                    //                    dateFormatter.timeStyle = .
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(PlaidAccountListResponse.self, from: data)
                    print(response)
                    completion(.success(response))
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
}
