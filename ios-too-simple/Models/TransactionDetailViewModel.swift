//
//  TransactionDetailViewModel.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 6/27/22.
//

import Foundation

class TransactionDetailViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var success: Bool = false
    
    func updateTransaction(
        transactionId: String,
        goalId: String?) async {
            let defaults = UserDefaults.standard
            let userId = defaults.string(forKey: "userId")
            let bearerToken = defaults.string(forKey: "jwt")
            
            if (userId == nil || bearerToken == nil) {
                return
            }
            
            loading = true
            do {
                let response = try await PlaidAccountService().updateTransaction(
                    transactionId: transactionId,
                    goalId: goalId ?? "",
                    bearerToken: bearerToken ?? "")
                loading = false
                
                if let isSuccessful = response.success {
                    success = isSuccessful
                }
            } catch {
                
            }
        }
}
