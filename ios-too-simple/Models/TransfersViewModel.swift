//
//  TransfersViewModel.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 6/15/22.
//

import Foundation

class TransfersViewModel: ObservableObject {
    @Published var goalList: GoalListResponse = GoalListResponse(goals: [GoalResponse]())
    @Published var loading: Bool = false
    @Published var buttonLoading: Bool = false
    @Published var success: Bool = false
    @Published var errorMessage: String = ""
    @Published var isErrored: Bool = false
    @Published var amount: Decimal?
    @Published var amountString = ""
    @Published var fromGoalId = ""
    @Published var toGoalId = ""
    @Published var note = ""
    
    func getGoals() {
        let defaults = UserDefaults.standard
        let userId = defaults.string(forKey: "userId")
        let bearerToken = defaults.string(forKey: "jwt")
        
        if (userId == nil || bearerToken == nil) {
            return
        }
        
        loading = true
        GoalService().getGoalsByUserId(
            userId: userId ?? "",
            bearerToken: bearerToken ?? "") { result in
                switch result {
                case .failure(let error):
                    print(error)
                    self.loading = false
                case .success(let apiResponse):
                    let success = apiResponse.success ?? false
                    if (!success) {
                        self.loading = false
                        print("non success code")
                    } else {
                        DispatchQueue.main.async {
                            self.loading = false
                            self.goalList.goals = apiResponse.goals
                            self.goalList.goals.insert(GoalResponse(goalName: "Ready to Spend"), at: 0)
                        }
                    }
                }
            }
    }
    
    func submitTransfer() async -> Void {
        let defaults = UserDefaults.standard
        let bearerToken = defaults.string(forKey: "jwt")
        
        if let bearerToken = bearerToken {
            do {
                self.buttonLoading = true
                if let amount = amount {
                    
                    let response = try await BudgetingService().saveTransfer(sourceId: fromGoalId,
                                                                             destinationId: toGoalId,
                                                                             amount: amount,
                                                                             note: note,
                                                                             bearerToken: bearerToken)
                    await MainActor.run {
                        let success = response.success ?? false
                        if !success {
                            self.buttonLoading = false
                            self.isErrored = true
                            self.errorMessage = response.errorMessage ?? "Something went wrong"
                        } else {
                            self.buttonLoading = false
                            self.isErrored = false
                            self.success = true
                        }
                    }
                }
            } catch {
                self.buttonLoading = false
                self.isErrored = true
                self.errorMessage = "Something went wrong."
            }
        }
    }
}
