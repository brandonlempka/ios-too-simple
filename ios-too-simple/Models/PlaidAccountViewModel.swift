//
//  PlaidAccountViewModel.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/11/22.
//

import Foundation

class PlaidAccountViewModel: ObservableObject {
    @Published var accountList: PlaidAccountListResponse = PlaidAccountListResponse(plaidAccounts: [PlaidAccountResponse]())
    @Published var transactionList: PlaidTransactionListResponse = PlaidTransactionListResponse(transactions: [PlaidTransactionResponse]())
    @Published var loading: Bool = false
    @Published var accountsFound: Bool = false
    @Published var transactionsFound: Bool = false
    @Published var dashboard: DashboardResponse = DashboardResponse(transactions: [PlaidTransactionResponse]())
    @Published var lastUpdatedDisplay: String = ""
    @Published var goalList:GoalListResponse = GoalListResponse(goals: [GoalResponse]())
    @Published var goalsFound: Bool = false
    
    func getPlaidAccounts() {
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "userId")
        let bearerToken = defaults.string(forKey: "jwt")
        
        if (userId == nil || bearerToken == nil) {
            return
        }
        
        loading = true
        PlaidAccountService().getPlaidAccountsByUserId(
            userId: userId ?? "",
            bearerToken: bearerToken ?? "") { result in
                switch result {
                case .failure(let error):
                    print(error)
                    self.loading = false
                case .success(let apiResponse):
                    let success = apiResponse.success ?? false
                    if (!success) {
                        self.loading = false
                        print("non success code")
                    } else {
                        DispatchQueue.main.async {
                            self.loading = false
                            if apiResponse.status != 204 {
                                self.accountsFound = true
                                self.accountList.plaidAccounts = apiResponse.plaidAccounts
                            }
                        }
                    }
                }
            }
    }
    
    func getPlaidTransactions() {
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "userId")
        let bearerToken = defaults.string(forKey: "jwt")
        
        if (userId == nil || bearerToken == nil) {
            return
        }
        
        loading = true
        PlaidAccountService().getPlaidTransactionsByUserId(
            userId: userId ?? "",
            bearerToken: bearerToken ?? "") { result in
                switch result {
                case .failure(let error):
                    print(error)
                    self.loading = false
                case .success(let apiResponse):
                    let success = apiResponse.success ?? false
                    if (!success) {
                        self.loading = false
                        print("non success code")
                    } else {
                        DispatchQueue.main.async {
                            self.loading = false
                            if apiResponse.status != 204 {
                                self.transactionsFound = true
                                self.transactionList.transactions = apiResponse.transactions
                            }
                        }
                    }
                }
            }
    }
    
    func getDashboard() {
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "userId")
        let bearerToken = defaults.string(forKey: "jwt")
        
        if (userId == nil || bearerToken == nil) {
            return
        }
        
        loading = true
        PlaidAccountService().getDashboardByUserId(
            userId: userId ?? "",
            bearerToken: bearerToken ?? "") { result in
                switch result {
                case .failure(let error):
                    print(error)
                    self.loading = false
                case .success(let apiResponse):
                    let success = apiResponse.success ?? false
                    if (!success) {
                        self.loading = false
                        print("non success code")
                    } else {
                        DispatchQueue.main.async {
                            self.loading = false
                            if apiResponse.transactions != nil && !apiResponse.transactions!.isEmpty {
                                self.transactionsFound = true
                                self.transactionList.transactions = apiResponse.transactions
                                if let lastUpdated = apiResponse.lastUpdated {
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateStyle = .medium
                                    dateFormatter.timeStyle = .medium
                                    dateFormatter.locale = Locale(identifier: "en_US")
                                    self.lastUpdatedDisplay = dateFormatter.string(from: lastUpdated)
                                }
                            }
                            
                            if let goals = apiResponse.goals {
                                if !goals.isEmpty {
                                    self.goalList.goals = goals
                                }
                            }
                            self.dashboard = apiResponse
                        }
                    }
                }
            }
    }
    
    func forcePlaidSync() {
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "userId")
        let bearerToken = defaults.string(forKey: "jwt")
        
        if (userId == nil || bearerToken == nil) {
            return
        }
        
        loading = true
        do {
            try? PlaidAccountService().forcePlaidResync(
                userId: userId ?? "",
                bearerToken: bearerToken ?? "") { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                        self.loading = false
                    case .success(let apiResponse):
                        let success = apiResponse.success ?? false
                        if (!success) {
                            self.loading = false
                            print("non success code")
                        } else {
                            self.loading = false
                            if apiResponse.status != 200 {
                                print(apiResponse.errorMessage ?? "Something went wrong")
                            }
                            
                            self.getDashboard()
                        }
                    }
                }
        } catch {
            print("whatup")
        }
    }
}
