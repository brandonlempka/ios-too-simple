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
                    .font(.headline)
                
                Spacer()
                
                Text(String(format: "$%.2f", goal.amountContributed))
                    .font(.headline)
            }
            
            Spacer()
            
            ProgressView(value: goal.amountContributed / goal.goalAmount > 0
                         ? goal.amountContributed / goal.goalAmount
                         : 0.5)
                .accentColor(Color("TooSimpleTeal"))
                .scaleEffect(x: 1, y: 3, anchor: .center)
            
            Text("Next contribution \(String(format: "$%.2f", goal.amountContributed)) on \(goal.nextContributionDate )")
                .font(.caption)
        }
        .padding()
    }
}

struct GoalCardView_Previews: PreviewProvider {
    static var goal = GoalResponse(goalId: "123", goalName: "testing", goalAmount: 123, desiredCompletionDate: "adf", userAccountId: "123", fundingScheduleId: "124", isExpense: false, recurrenceTimeFrame: 1, creationDate: "123", isPaused: false, autoSpendMerchantName: "asdlkfasdf", amountContributed: 123.12, amountSpent: 123, isAutoRefillEnabled: false, nextContributionAmount: 123, nextContributionDate: "adsf", isContributionFixed: false, isArchived: false, success: true, status: 1, errorMessage: "123 ")
    static var previews: some View {
        GoalCardView(goal: goal)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
