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
        VStack(alignment: .leading) {
            HStack {
                Text(plaidTransaction.name ?? "Unknown merchant")

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
                
                Spacer()
                
                Text(String(format: "$%.2f", plaidTransaction.amount))
                    .foregroundColor(plaidTransaction.amount < 0
                                     ? .black
                                     : .green)
            }
            .font(.subheadline)
            
            HStack {
                if let merchantName = plaidTransaction.merchantName {
                    Text(merchantName)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text(plaidTransaction.plaidAccountDisplayName)
            }
        }
        .padding(5)
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
