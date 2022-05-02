//
//  BalanceView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 4/12/22.
//

import SwiftUI

struct BalanceCardView: View {
    var availableBalance: Double
    var availableBalanceDisplay: String
    init() {
        availableBalance = 1235;
        availableBalanceDisplay = String(format: "$%.2f", availableBalance)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 400, height: 150)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 20)
            HStack {
                VStack {
                    Text(availableBalanceDisplay)
                        .font(.title)
                        .foregroundColor(
                            (availableBalance == 0
                              ? .black
                              : availableBalance > 0
                              ? .green
                             : .red))
                    Text("Ready to Spend")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .multilineTextAlignment(.leading)
                .padding(16.0)
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .padding()
                    .foregroundColor(.gray)
                
            }
            //.sheet(isPresented: .constant(true), content: { LoginView(isLoggedIn: )})
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceCardView()
    }
}
