//
//  GoalListResponse.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/2/22.
//

import Foundation

struct GoalListResponse: Codable {
    var goals: [GoalResponse]
    var success: Bool?
    var status: Int?
    var errorMessage: String?
}
