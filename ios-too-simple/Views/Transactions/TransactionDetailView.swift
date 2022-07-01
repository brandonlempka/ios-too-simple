//
//  TransactionDetailView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/22/22.
//

import SwiftUI

struct TransactionDetailView: View {
    @State var transaction: PlaidTransactionResponse
    @State var goals: [GoalResponse]
    @State private var isPresentingEditView = false
    @State var spendingGoal = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("TooSimplePurple"))
            Text("Back")
        }
    }
    }
    var body: some View {
        VStack {
            if transaction.isPending {
                Text("Pending")
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.red, lineWidth: 1)
                    )
            }
            
            List {
                Section(transaction.transactionDateTimeDisplay ?? "Date Unknown") {
                    HStack {
                        Text("Amount")
                        Spacer()
                        if transaction.amount * -1 > 0 {
                            Text(String(format: "$%.2f", transaction.amount * -1))
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                        } else {
                            Text(String(format: "$%.2f", transaction.amount * -1))
                                .fontWeight(.semibold)
                        }
                    }
                    .accessibilityElement(children: .combine)
                    
                    HStack {
                        Text("Account")
                        Spacer()
                        Text(transaction.plaidAccountDisplayName)
                    }
                    .accessibilityElement(children: .combine)
                    
                    HStack {
                        Picker("Spending From", selection: $spendingGoal, content: {
                            ForEach(goals) { goal in
                                let goalBalance = String(format: "$%.2f", goal.amountContributed - goal.amountSpent)
                                if goal.goalId == "" {
                                    Text("\(goal.goalName)")
                                } else {
                                    Text("\(goal.goalName) - \(goalBalance)")
                                }
                            }
                        })
                        .onChange(of: spendingGoal) { goal in
                            let transactionVM = TransactionDetailViewModel()
                            let goalId:String = goal
                            Task {
                                await transactionVM.updateTransaction(transactionId: transaction.id, goalId: goalId)
                            }
                        }
                    }
                    .accessibilityElement(children: .combine)
                    
                    HStack {
                        Text("Spending Categories")
                        Spacer()
                        VStack {
                            if let category = transaction.primaryCategory {
                                Capsule()
                                    .fill(Color("TooSimpleTeal"))
                                    .frame(width: 100, height: 25, alignment: .trailing)
                                    .overlay(Text(category
                                        .replacingOccurrences(of: "_", with: " "))
                                        .font(.footnote))
                                if let detailedCategory = transaction.detailedCategory {
                                    Capsule()
                                        .fill(Color("TooSimpleTeal"))
                                        .frame(width: 100, height: 25, alignment: .trailing)
                                        .overlay(Text(detailedCategory
                                            .replacingOccurrences(of: category, with: "")
                                            .replacingOccurrences(of: "_", with: " "))
                                            .font(.footnote))
                                }
                            }
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            }
            .navigationTitle(transaction.merchantName ?? transaction.name ?? "Unknown Merchant")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton, trailing: Button("Edit") {
                self.isPresentingEditView = true
            })
        }
        .onAppear {
            self.goals.insert(GoalResponse(goalName: "Ready to Spend"), at: 0)
        }
    }
}

//struct TransactionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        var transaction = PlaidTransactionResponse(plaidTransactionId: "123", amount: 123.12, primaryCategory: "asdfasdf", detailedCategory: "asdafasdfasd", isPending: true, plaidAccountId: "123123", plaidAccountDisplayName: "Spending Money", userAccountId: "123123")
//        let goals = [GoalResponse]()
//        TransactionDetailView(transaction: transaction, goals: goals)
//    }
//}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
