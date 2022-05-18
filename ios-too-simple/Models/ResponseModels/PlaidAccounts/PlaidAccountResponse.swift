//
//  PlaidAccountResponse.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/11/22.
//

import Foundation

struct PlaidAccountResponse: Codable, Identifiable {
    var id: String {
        return plaidAccountId
    }
    
    var plaidAccountId: String
    var plaidAccountTypeId: Int
    var userAccountId: String
    var mask: String
    var name: String
    var nickName: String?
    var currentBalance: Double
    var availableBalance: Double?
    var creditLimit: Double?
    var currencyCode: String
    var accessToken: String
    var lastUpdated: String?
    var isActiveForBudgetingFeatures: Bool
    var isPlaidRelogRequired: Bool
    var itemId: String
}
