//
//  AccountsView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/11/22.
//

import SwiftUI

struct AccountsView: View {
    @ObservedObject var plaidAccountsVM: PlaidAccountViewModel
    @State var addMode: Bool
    
    var body: some View {
        NavigationView {
            if plaidAccountsVM.loading {
                ProgressView()
            }
            if !plaidAccountsVM.accountsFound {
                Text("No accounts found. Get started by adding one above!")
            }
            List {
                ForEach(plaidAccountsVM.accountList.plaidAccounts) { account in
                    NavigationLink(destination: AccountDetailView(account: account)) {
                        Text(account.nickName ?? account.name)
                    }
                }
            }
            .navigationTitle("Accounts")
            .navigationBarItems(trailing: Button(action: {
                // button activates link
                self.addMode = true
            } ) {
                Image(systemName: "plus")
                    .resizable()
                    .padding(6)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .foregroundColor(Color.accentColor)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            plaidAccountsVM.getPlaidAccounts()
        }
    }
}

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView(plaidAccountsVM: PlaidAccountViewModel(),
                     addMode: false)
    }
}
