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
    let goalId: String
    let goalName: String
    let goalAmount: Double
    let desiredCompletionDate: String?
    let userAccountId: String?
    let fundingScheduleId: String?
    let isExpense: Bool?
    let recurrenceTimeFrame: Int?
    let creationDate: String?
    let isPaused: Bool?
    let autoSpendMerchantName: String?
    let amountContributed: Double
    let amountSpent: Double?
    let isAutoRefillEnabled: Bool?
    let nextContributionAmount: Double?
    let nextContributionDate: String?
    let isContributionFixed: Bool?
    let isArchived: Bool?
    let success: Bool?
    let status: Int?
    let errorMessage: String?
}
