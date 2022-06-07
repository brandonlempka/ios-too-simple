//
//  GoalDetailView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/2/22.
//

import SwiftUI

struct GoalDetailView: View {
    @State var existingGoal: GoalResponse
    @State private var isPresentingEditView = false
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Goal Info")) {
                    HStack {
                        Text("Goal Name")
                        Spacer()
                        Text(existingGoal.goalName)
                    }.accessibilityElement(children: .combine)
                    
                    HStack {
                        Text("Completion Date")
                        Spacer()
                        Text(existingGoal.nextContributionDateDisplay)
                    }.accessibilityElement(children: .combine)
                    
                    HStack {
                        Text("Amount")
                        Spacer()
                        Text(String(format: "$%.2f", existingGoal.goalAmount))
                    }.accessibilityElement(children: .combine)
                    
                    HStack {
                        Text("Funding Schedule")
                        Spacer()
                        Text(existingGoal.fundingScheduleId)
                    }.accessibilityElement(children: .combine)
                    
                    HStack {
                        Text("Automatic Contributions")
                        Spacer()
                        Text(existingGoal.isPaused
                             ? "Paused"
                             : "Active")
                    }
                    .accessibilityElement(children: .combine)
                }
            }
            .navigationTitle(existingGoal.goalName)
            .toolbar {
                Button("Edit") {
                    isPresentingEditView = true
                }
            }
            .sheet(isPresented: $isPresentingEditView) {
                NavigationView {
                    
                    GoalEditView(goal: existingGoal)
                        .navigationTitle(existingGoal.goalName)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                }
                            }
                        }
                }
            }
        }
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var goal = GoalResponse(goalId: "123", goalName: "testing", goalAmount: 123, desiredCompletionDate: Date(), userAccountId: "123", fundingScheduleId: "124", isExpense: false, recurrenceTimeFrame: 1, creationDate: "123", isPaused: false, autoSpendMerchantName: "asdlkfasdf", amountContributed: 123.12, amountSpent: 123, isAutoRefillEnabled: false, nextContributionAmount: 123, nextContributionDate: Date(), isContributionFixed: false, isArchived: false, success: true, status: 1, errorMessage: "123 ")
    static var previews: some View {
        NavigationView {
            GoalDetailView(existingGoal: goal)
        }
    }
}
