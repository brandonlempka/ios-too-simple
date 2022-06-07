//
//  GoalEditView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/2/22.
//

import SwiftUI

struct GoalEditView: View {
    @State var goal: GoalResponse
    
    var body: some View {
        Form {
            Section(header: Text("Goal Info")) {
                HStack {
                    Text("Goal Name")
                    Spacer()
                    TextField("Goal Name", text: $goal.goalName)
                }
                
                TextField("Amount Needed",
                          value: $goal.goalAmount,
                          formatter: NumberFormatter())
                .keyboardType(.decimalPad)
                if goal.isContributionFixed {
                    TextField("Amount to Contribute",
                              value: $goal.nextContributionAmount,
                              formatter: NumberFormatter())
                }
            }
            
            Section(header: Text("Contribution Options")) {
                
                Toggle("Fixed Contributions", isOn: $goal.isContributionFixed)
                Toggle("Pause Automatic Contributions", isOn: $goal.isPaused)
                Toggle("Refill Goal Automatically", isOn: $goal.isAutoRefillEnabled)
            }
        }
    }
}

struct GoalEditView_Previews: PreviewProvider {
    static var goal = GoalResponse(goalId: "123", goalName: "testing", goalAmount: 123, desiredCompletionDate: Date(), userAccountId: "123", fundingScheduleId: "124", isExpense: false, recurrenceTimeFrame: 1, creationDate: "123", isPaused: false, autoSpendMerchantName: "asdlkfasdf", amountContributed: 123.12, amountSpent: 123, isAutoRefillEnabled: false, nextContributionAmount: 123, nextContributionDate: Date(), isContributionFixed: false, isArchived: false, success: true, status: 1, errorMessage: "123 ")
    static var previews: some View {
        GoalEditView(goal: goal)
    }
}
