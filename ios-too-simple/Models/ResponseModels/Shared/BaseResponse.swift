//
//  BaseResponse.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/18/22.
//

import Foundation

struct BaseResponse: Codable {
    var success: Bool?
    var status: Int?
    var errorMessage: String?
}
