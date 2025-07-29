//
//  DateUtils.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 28/9/24.
//

import Foundation

final class DateUtils {
    static let backendFormat = "yyyy-MM-dd"

    class func getToday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = backendFormat
        return formatter.string(from: .now)
    }
}
