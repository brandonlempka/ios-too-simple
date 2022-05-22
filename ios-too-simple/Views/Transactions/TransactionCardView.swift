//
//  TransactionCardView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/18/22.
//

import SwiftUI

struct TransactionCardView: View {
    let plaidTransaction: PlaidTransactionResponse
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(plaidTransaction.merchantName ?? plaidTransaction.name ?? "Unknown")
                        .fontWeight(.semibold)
                    
                    if plaidTransaction.isPending {
                        Text("Pending")
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.red, lineWidth: 1)
                            )
                    }
                }
                .font(.subheadline)
                
                HStack {
                    
                    if let transactionDate = plaidTransaction.transactionDateDisplay {
                        Text(transactionDate)
                    }
                    
                    if let accountName = plaidTransaction.plaidAccountDisplayName {
                        Text("•")
                        Text(accountName)
                        
                    }
                }
                .foregroundColor(.gray)
                .font(.subheadline)
                if let goalName = plaidTransaction.spendingFromGoalId {
                    Text("Spent from \(goalName)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
            }
            
            Spacer()
            
            if plaidTransaction.amount * -1 > 0 {
                Text(String(format: "$%.2f", plaidTransaction.amount * -1))
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
            } else {
                Text(String(format: "$%.2f", plaidTransaction.amount))
                    .fontWeight(.semibold)
            }
        }
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        let plaidTransaction = PlaidTransactionResponse(
            plaidTransactionId: "123", amount: -17.32, merchantName: "Hi hi", name: "Test name", isPending: true, plaidAccountId: "hi hi hi", plaidAccountDisplayName: "Test acount", userAccountId: "456"
        )
        
        TransactionCardView(plaidTransaction: plaidTransaction)
    }
}
