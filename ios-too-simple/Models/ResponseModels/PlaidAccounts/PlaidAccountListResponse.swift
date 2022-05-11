//
//  PlaidAccountListResponse.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/11/22.
//

import Foundation

struct PlaidAccountListResponse: Codable {
    var plaidAccounts: [PlaidAccountResponse]
    var success: Bool?
    var status: Int?
    var errorMessage: String?
}
