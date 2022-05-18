//
//  PlaidTransactionListResponse.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/17/22.
//

import Foundation

struct PlaidTransactionListResponse: Codable {
    var transactions: [PlaidTransactionResponse]
    var success: Bool?
    var status: Int?
    var errorMessage: String?
}
