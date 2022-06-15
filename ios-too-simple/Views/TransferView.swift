//
//  TransferView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 6/6/22.
//

import SwiftUI

struct TransferView: View {
    @State private var amount: Decimal?
    @State private var amountString = ""
    private let numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
    }
    var body: some View {
        NavigationView {
            Form {
                
                TextField("Transfer Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            
                        }
                    }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                
                Button(action: {
                    amount = 0
                }) {
                    Text("Submit").frame(minWidth: 0, maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
            }
            .navigationBarTitle("Transfer")
        }
        .navigationBarHidden(false)
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
