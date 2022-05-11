//
//  Goal.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 4/13/22.
//

import Foundation

struct GoalResponse: Codable, Identifiable {
    var id: String {
        return goalId
    }
    var goalId: String
    var goalName: String
    var goalAmount: Double
    var desiredCompletionDate: String
    var userAccountId: String
    var fundingScheduleId: String
    var isExpense: Bool
    var recurrenceTimeFrame: Int
    var creationDate: String
    var isPaused: Bool
    var autoSpendMerchantName: String
    var amountContributed: Double
    var amountSpent: Double
    var isAutoRefillEnabled: Bool
    var nextContributionAmount: Double
    var nextContributionDate: String
    var isContributionFixed: Bool
    var isArchived: Bool
    var success: Bool?
    var status: Int?
    var errorMessage: String?
}
