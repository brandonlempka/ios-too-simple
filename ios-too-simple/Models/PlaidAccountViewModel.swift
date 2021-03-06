//
//  PlaidAccountViewModel.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/11/22.
//

import Foundation

class PlaidAccountViewModel: ObservableObject {
    @Published var accountList: PlaidAccountListResponse = PlaidAccountListResponse(plaidAccounts: [PlaidAccountResponse]())
    @Published var loading: Bool = false
    @Published var accountsFound: Bool = false
    
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
}
