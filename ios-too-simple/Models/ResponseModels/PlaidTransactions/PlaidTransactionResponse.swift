//
//  PlaidTransactionResponse.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/17/22.
//

import Foundation

struct PlaidTransactionResponse: Codable, Identifiable {
    var id: String {
        return plaidTransactionId
    }
    
    var plaidTransactionId: String
    var accountOwner: String?
    var amount: Double
    var authorizedDate: Date?
    var transactionDate: Date?
    var transactionDateDisplay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: transactionDate ?? Date())
    }
    var categoryId: String?
    var primaryCategory: String?
    var detailedCategory: String?
    var currencyCode: String?
    var address: String?
    var city: String?
    var country: String?
    var latitude: String?
    var longitude: String?
    var postalCode: String?
    var region: String?
    var storeNumber: String?
    var merchantName: String?
    var name: String?
    var paymentChannel: String?
    var byOrderOf: String?
    var payee: String?
    var payer: String?
    var paymentMethod: String?
    var paymentProcessor: String?
    var ppdId: String?
    var reason: String?
    var referenceNumber: String?
    var isPending: Bool
    var pendingTransactionId: String?
    var transactionCode: String?
    var transactionType: String?
    var unofficialCurrencyCode: String?
    var spendingFromGoalId: String?
    var plaidAccountId: String
    var plaidAccountDisplayName: String
    var userAccountId: String
}
