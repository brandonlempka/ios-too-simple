//
//  GoalViewModel.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/2/22.
//

import Foundation

class GoalViewModel: ObservableObject {
    @Published var goalList: GoalListResponse = GoalListResponse(goals: [GoalResponse]())
    
    func getGoals() {
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "userId")
        let bearerToken = defaults.string(forKey: "jwt")
        
        if (userId == nil || bearerToken == nil) {
            return
        }
        
        GoalService().getGoalsByUserId(
            userId: userId ?? "",
            bearerToken: bearerToken ?? "") { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let apiResponse):
                    let success = apiResponse.success ?? false
                    if (!success) {
                        print("non success code")
                    } else {
                        DispatchQueue.main.async {
                            self.goalList.goals = apiResponse.goals
                        }
                    }
                }
            }
    }
}
