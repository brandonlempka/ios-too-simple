//
//  DateFormatter.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 5/22/22.
//

import Foundation

extension DateFormatter {
   static let MMddyy: DateFormatter = {
      let formatter = DateFormatter()
      formatter.timeZone = TimeZone(abbreviation: "UTC") //TimeZone.current
      formatter.dateFormat = "MM/dd/yy"
      return formatter
   }()
}


extension Date {
   func formatToString(using formatter: DateFormatter) -> String {
      return formatter.string(from: self)
   }
}
