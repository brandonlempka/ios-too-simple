//
//  AccountService.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/11/22.
//

import Foundation

class PlaidAccountService {
    var plaidAccounts = PlaidAccountListResponse(plaidAccounts: [PlaidAccountResponse]())
    var plaidTransactions = PlaidTransactionListResponse(transactions: [PlaidTransactionResponse]())
    
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
    
    func getPlaidTransactionsByUserId(
        userId: String,
        bearerToken: String,
        accountFilter: String?,
        completion: @escaping (Result<PlaidTransactionListResponse, Error>) -> Void) {
            guard let url = URL(string: "https://api.brandonlempka.com/api/PlaidTransactions/searchTransactions") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            let body: [String: AnyHashable] = [
                "userId": userId,
                "accountIdFilter": accountFilter ?? ""
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    print (error!)
                    return
                }
                
                do {
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 204 {
                            completion(.success(PlaidTransactionListResponse(success: true, status: 204)))
                        } else {
                            let decoder = JSONDecoder()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                            decoder.dateDecodingStrategy = .formatted(dateFormatter)
                            
                            let response = try decoder.decode(PlaidTransactionListResponse.self, from: data)
                            print(response)
                            completion(.success(response))
                        }
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    
    func getDashboardByUserId(
        userId: String,
        bearerToken: String,
        completion: @escaping (Result<DashboardResponse, Error>) -> Void) {
            guard let url = URL(string: "https://api.brandonlempka.com/api/Budgeting/getDashboard/\(userId)") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    print (error!)
                    return
                }
                
                do {
                    if response is HTTPURLResponse {
                        let decoder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
                        let response = try decoder.decode(DashboardResponse.self, from: data)
                        completion(.success(response))
                    }
                } catch {
                    print(error)
                }
            })
            task.resume()
        }
    
//    @available(*, renamed: "forcePlaidResync(userId:bearerToken:)")
//    func forcePlaidResync(
//        userId: String,
//        bearerToken: String,
//        completion: @escaping (Result<BaseResponse, Error>) -> Void) {
//            Task {
//                do {
//                    let result = try await forcePlaidResync(userId: userId, bearerToken: bearerToken)
//                    completion(.success(result))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//        }
    
    
    func forcePlaidResync(
        userId: String,
        bearerToken: String) async throws -> BaseResponse {
            guard let url = URL(string: "https://api.brandonlempka.com/api/Plaid/forcePlaidSync/\(userId)") else {
                return BaseResponse()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            
            return try await withCheckedThrowingContinuation { continuation in
                let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                    guard let data1 = data, error == nil else {
                        continuation.resume(with: .failure(error!))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(BaseResponse.self, from: data1)
                        continuation.resume(with: .success(response))
                    } catch {
                        print("hi")
                    }
                })
                task.resume()
            }
        }
    
    func updateTransaction(
        transactionId: String,
        goalId: String,
        bearerToken: String) async throws -> BaseResponse {
            guard let url = URL(string: "https://api.brandonlempka.com/api/PlaidTransactions") else {
                return BaseResponse()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            
            let body: [String: AnyHashable] = [
                "spendingFromGoalId": goalId,
                "plaidTransactionId": transactionId
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            return try await withCheckedThrowingContinuation { continuation in
                let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                    guard let data1 = data, error == nil else {
                        continuation.resume(with: .failure(error!))
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(BaseResponse.self, from: data1)
                        continuation.resume(with: .success(response))
                    } catch {
                        print("hi")
                    }
                })
                task.resume()
            }
        }
}
