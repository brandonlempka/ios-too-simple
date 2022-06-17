//
//  BudgetingService.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 6/17/22.
//

import Foundation

class BudgetingService {
    func saveTransfer(sourceId: String, destinationId: String, amount: Decimal, note: String, bearerToken: String) async throws -> BaseResponse {
        guard let url = URL(string: "https://api.brandonlempka.com/api/Budgeting/moveMoney") else {
            return BaseResponse()
            //throw?
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let body: [String: AnyHashable] = [
            "sourceGoalId": sourceId,
            "destinationGoalId": destinationId,
            "amount": amount,
            "note": note
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let (data, response) = try await URLSession.shared.data(for: request)
        let httpresponse = response as? HTTPURLResponse
        let status = httpresponse?.statusCode
        print(status)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//          //throw "The server responded with an error."
//            return BaseResponse()
//        }

        guard let baseResponseModel = try? JSONDecoder()
          .decode(BaseResponse.self, from: data) else {
          //throw "The server response was not recognized."
            return BaseResponse()
        }
        
        return baseResponseModel
    }
}
