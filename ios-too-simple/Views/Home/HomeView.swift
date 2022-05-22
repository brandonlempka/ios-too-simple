//
//  HomeView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/17/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var plaidAccountsVM: PlaidAccountViewModel
    @State var accountBreakdown: Bool
    
    var body: some View {
        VStack {
            NavigationView {
                if plaidAccountsVM.loading {
                    ProgressView()
                }
                if let transactions = plaidAccountsVM.transactionList.transactions {
                        List {
                            Section(header: Text("Last updated \(plaidAccountsVM.lastUpdatedDisplay)")) {
                            if !plaidAccountsVM.transactionsFound {
                                Text("No transactions found.")
                            } else {
                                ForEach(transactions) { transaction in
                                    NavigationLink(destination: TransactionDetailView()) {
                                        TransactionCardView(plaidTransaction: transaction)
                                    }
                                }
                            }
                        }
                    }
                    .refreshable {
                        plaidAccountsVM.forcePlaidSync()
                    }
                    .navigationTitle(String(format: "$%.2f", plaidAccountsVM.dashboard.readyToSpend ?? 0))
                    .navigationBarItems(trailing: Button(action: {
                        self.accountBreakdown = true
                    }) {
                        Image(systemName: "info.circle")
                    })
                    .sheet(isPresented: $accountBreakdown, content: {
                        VStack {
                            List {
                                Section(header: Text("Funding Breakdown")) {
                                    HStack {
                                        Text("Deposits")
                                        Spacer()
                                        Text(String(format: "$%.2f", plaidAccountsVM.dashboard.depositoryAmount ?? 0))
                                    }
                                    .accessibilityElement(children: .combine)
                                    
                                    HStack {
                                        Text("Credits")
                                        Spacer()
                                        Text(String(format: "$%.2f", plaidAccountsVM.dashboard.creditAmount ?? 0))
                                    }
                                    .accessibilityElement(children: .combine)
                                    
                                    HStack {
                                        Text("Goals")
                                        Spacer()
                                        Text(String(format: "$%.2f", plaidAccountsVM.dashboard.goalAmount ?? 0))
                                    }
                                    .accessibilityElement(children: .combine)
                                    
                                    HStack {
                                        Text("Expenses")
                                        Spacer()
                                        Text(String(format: "$%.2f", plaidAccountsVM.dashboard.expenseAmount ?? 0))
                                    }
                                    .accessibilityElement(children: .combine)
                                    
                                    HStack {
                                        Text("Ready to Spend")
                                        Spacer()
                                        Text(String(format: "$%.2f", plaidAccountsVM.dashboard.readyToSpend ?? 0))
                                    }
                                    .accessibilityElement(children: .combine)
                                    .foregroundColor(plaidAccountsVM.dashboard.readyToSpend ?? 0 > 0
                                                     ? .green
                                                     : .red)
                                }
                            }
                        }
                    })
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                plaidAccountsVM.getDashboard()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(plaidAccountsVM: PlaidAccountViewModel(), accountBreakdown: false)
    }
}
