//
//  AccountView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 6/18/22.
//

import SwiftUI

struct AccountDetailView: View {
    @State var account: PlaidAccountResponse
    @ObservedObject var accountVM = PlaidAccountViewModel()
    
    var body: some View {
        List {
            Section(header: Text("Account Info")) {
                if account.nickName != nil {
                    HStack {
                        Text("Account Name")
                        Spacer()
                        Text(account.name)
                    }.accessibilityElement(children: .combine)
                }
                
                HStack {
                    Text("Current Balance")
                    Spacer()
                    Text(String(format: "$%.2f", account.currentBalance))
                }
                .accessibilityElement(children: .combine)
                
                HStack {
                    Text("Available Balance")
                    Spacer()
                    Text(String(format: "$%.2f", account.availableBalance ?? 0))
                }
                .accessibilityElement(children: .combine)
                
                if let limit = account.creditLimit {
                    HStack {
                        Text("Credit Limit")
                        Spacer()
                        Text(String(format: "$%.2f", limit))
                    }
                    .accessibilityElement(children: .combine)
                }
                
                HStack {
                    Text("Use for Budgeting?")
                    Spacer()
                    Text(account.isActiveForBudgetingFeatures ? "Active" : "Inactive")
                }
                .accessibilityElement(children: .combine)
            }
            
            if accountVM.transactionsFound {
                if let transactions = accountVM.transactionList.transactions {
                    if transactions.count > 0 {
                        Section(header: Text("Transactions")) {
                            ForEach(transactions) { transaction in
                                NavigationLink(destination: TransactionDetailView(transaction: transaction, goals: accountVM.goalList.goals)) {
                                    TransactionCardView(plaidTransaction: transaction)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        .navigationTitle(account.nickName ?? account.name)
        .onAppear {
            accountVM.getPlaidTransactions(accountFilter: account.id)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let account = PlaidAccountResponse(plaidAccountId: "123", plaidAccountTypeId: 1, userAccountId: "123", mask: "123", name: "Hi", currentBalance: 1123, currencyCode: "a", accessToken: "123", isActiveForBudgetingFeatures: true, isPlaidRelogRequired: false, itemId: "123")
        AccountDetailView(account: account, accountVM: PlaidAccountViewModel())
    }
}
