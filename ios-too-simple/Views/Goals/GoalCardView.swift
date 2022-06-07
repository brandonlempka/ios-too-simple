//
//  GoalCardView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/2/22.
//

import SwiftUI

struct GoalCardView: View {
    let goal: GoalResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(goal.goalName)
                
                Spacer()
                
                Text(String(format: "$%.2f", goal.amountContributed))
            }
            .font(.headline)
            
            Spacer()
            
            ProgressView(value: goal.amountContributed > 0
                         ? goal.amountContributed / goal.goalAmount
                         : 0)
            .accentColor(Color("TooSimpleTeal"))
            .scaleEffect(x: 1, y: 3, anchor: .center)
            
            if let nextDate = goal.nextContributionDateDisplay {
                if goal.isPaused {
                    Text("Paused")
                        .font(.caption)
                }
                else if nextDate != "Dec 31, 9999" {
                    Text("Next contribution \(String(format: "$%.2f", goal.nextContributionAmount)) on \(nextDate)")
                        .font(.caption)
                }
                else {
                    Text("Complete")
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

struct GoalCardView_Previews: PreviewProvider {
    static var goal = GoalResponse(goalId: "123", goalName: "testing", goalAmount: 123, desiredCompletionDate: Date(), userAccountId: "123", fundingScheduleId: "124", isExpense: false, recurrenceTimeFrame: 1, creationDate: "123", isPaused: false, autoSpendMerchantName: "asdlkfasdf", amountContributed: 123.12, amountSpent: 123, isAutoRefillEnabled: false, nextContributionAmount: 123, nextContributionDate: Date(), isContributionFixed: false, isArchived: false, success: true, status: 1, errorMessage: "123 ")
    static var previews: some View {
        GoalCardView(goal: goal)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
