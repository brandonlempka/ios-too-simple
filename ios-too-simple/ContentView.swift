//
//  ContentView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 4/8/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var loginVM = LoginViewModel()
    
    var body: some View {
        if (!loginVM.isAuthenticated) {
            LoginView(loginVM: loginVM)
        } else {
            TabView {
                VStack {
                    BalanceCardView()
                    Button("Logout") {
                        loginVM.logout()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(Color("TooSimplePurple"))
                    .frame(width: 350, height: 50, alignment: .center)
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                AccountsView()
                    .tabItem {
                        Image(systemName: "building.columns.fill")
                        Text("Accounts")
                    }
                GoalsView(goalVM: GoalViewModel(), addMode: false)
                    .tabItem {
                        Image(systemName: "text.alignleft")
                        Text("Goals")
                    }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
