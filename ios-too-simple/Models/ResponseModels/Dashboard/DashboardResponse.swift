//
//  DashboardResponse.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/20/22.
//

import Foundation
struct DashboardResponse: Codable {
    var readyToSpend: Double?
    var depositoryAmount: Double?
    var creditAmount: Double?
    var goalAmount: Double?
    var expenseAmount: Double?
    var lastUpdated: Date?
    var transactions: [PlaidTransactionResponse]?
    var goals: [GoalResponse]?
    var success: Bool?
    var status: Int?
    var errorMessage: String?
}
