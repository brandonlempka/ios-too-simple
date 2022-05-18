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
                if (plaidAccountsVM.loading) {
                    ProgressView()
                }
                List {
                    ForEach(plaidAccountsVM.transactionList.transactions) { transaction in
                        NavigationLink(destination: Text(transaction.name ?? "hi")) {
                            TransactionCardView(plaidTransaction: transaction)
                        }
                    }
                }
                .refreshable {
                    plaidAccountsVM.getPlaidTransactions()
                }
                .navigationBarTitle {
                    Button(action: {
                        self.accountBreakdown = true
                    }) {
                        HStack {
                            VStack {
                                Text(String(format: "$%.2f", 123.45))
                                    .font(.headline)
                                    .foregroundColor(-123.45 > 0
                                                      ? .black
                                                      : .red)
                                Text("Ready to Spend")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color("TooSimpleTeal"))
                        }
                    }
                    .sheet(isPresented: $accountBreakdown, content: {
                        Text("Breakdown could go here.")
                    })
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                plaidAccountsVM.getPlaidTransactions()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(plaidAccountsVM: PlaidAccountViewModel(), accountBreakdown: false)
    }
}

extension View {
    func navigationBarTitle<Content>(
        @ViewBuilder content: () -> Content
    ) -> some View where Content : View {
        self.toolbar {
            ToolbarItem(placement: .principal, content: content)
        }
    }
}
