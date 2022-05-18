//
//  GoalsView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/2/22.
//

import SwiftUI

struct GoalsView: View {
    @ObservedObject var goalVM: GoalViewModel
    @State var addMode: Bool
    
    var body: some View {
        NavigationView {
            if goalVM.loading {
                ProgressView()
            }
            List {
                ForEach(goalVM.goalList.goals) { goal in
                    NavigationLink(destination: GoalDetailView(existingGoal: goal)) {
                        GoalCardView(goal: goal)
                    }
                }
            }
            .navigationTitle("Goals")
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
        
        
        // invisible link inside NavigationView for add mode
        //        NavigationLink(destination: GoalDetailView(existingGoal: nil),
        //            isActive: $addMode) { EmptyView() }
        .onAppear {
            goalVM.getGoals()
        }
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            GoalsView(goalVM: GoalViewModel(),
                      addMode: false)
        }
    }
}
