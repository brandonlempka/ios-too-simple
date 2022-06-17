//
//  TransferView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 6/6/22.
//

import SwiftUI
import AlertToast

struct TransferView: View {
    @ObservedObject var transfersVM: TransfersViewModel

    private let numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        transfersVM = TransfersViewModel()
    }
    var body: some View {
        NavigationView {
            //            if transfersVM.loading {
            //                ProgressView()
            //            }
            
            if transfersVM.goalList.goals.count > 0 {
                Form {
                    Picker("From Goal", selection: $transfersVM.fromGoalId, content: {
                        ForEach(transfersVM.goalList.goals) { goal in
                            let goalBalance = String(format: "$%.2f", goal.amountContributed - goal.amountSpent)
                            Text("\(goal.goalName) - \(goalBalance)")
                        }
                    })
                    
                    Picker("To Goal", selection: $transfersVM.toGoalId, content: {
                        ForEach(transfersVM.goalList.goals) { goal in
                            let goalBalance = String(format: "$%.2f", goal.amountContributed - goal.amountSpent)
                            Text("\(goal.goalName) - \(goalBalance)")
                        }
                    })
                    
                    TextField("Transfer Amount", value: $transfersVM.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                            }
                        }
                    
                    TextField("Note", text: $transfersVM.note)
                    //.lineLimit(5...10) <-- turn on for ios16
                    
                    Button(action: {
                        Task {
                            await transfersVM
                                .submitTransfer()
                        }
                    }) {
                        if transfersVM.buttonLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(minWidth: 0, maxWidth: .infinity)
                        } else {
                            Text("Submit").frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                }

                .navigationBarTitle("Transfer")
            }
        }
        .toast(isPresenting: $transfersVM.success, duration: 2, tapToDismiss: true) {
            AlertToast(displayMode: .banner(.slide),
                       type: .complete(Color(UIColor.systemBackground)),
                       title: "Successfully transferred",
                       style: AlertToast.AlertStyle.style(backgroundColor: .green, titleColor: Color(UIColor.systemBackground)))
        }
        
        .toast(isPresenting: $transfersVM.isErrored, duration: 2, tapToDismiss: true) {
            AlertToast(displayMode: .banner(.slide),
                       type: .complete(Color(UIColor.systemBackground)),
                       title: "Error",
                       subTitle: transfersVM.errorMessage,
                       style: AlertToast.AlertStyle.style(backgroundColor: .red, titleColor: Color(UIColor.systemBackground)))
        }
        .navigationBarHidden(false)
        .onAppear {
            transfersVM.getGoals()
        }
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
