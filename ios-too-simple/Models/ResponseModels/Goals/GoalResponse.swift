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
    var goalId: String = ""
    var goalName: String = ""
    var goalAmount: Double = 0
    var desiredCompletionDate: Date?
    var desiredCompletionDateDisplay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: desiredCompletionDate ?? Date())
    }
    var userAccountId: String = ""
    var fundingScheduleId: String = ""
    var isExpense: Bool = false
    var recurrenceTimeFrame: Int = 0
    var creationDate: String = ""
    var isPaused: Bool = false
    var autoSpendMerchantName: String = ""
    var amountContributed: Double = 0
    var amountSpent: Double = 0
    var isAutoRefillEnabled: Bool = false
    var nextContributionAmount: Double = 0
    var nextContributionDate: Date?
    var nextContributionDateDisplay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: nextContributionDate ?? Date())
    }
    var isContributionFixed: Bool = false
    var isArchived: Bool = false
    var success: Bool?
    var status: Int?
    var errorMessage: String?
}
