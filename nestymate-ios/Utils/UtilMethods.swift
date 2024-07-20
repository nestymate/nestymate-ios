//
//  UtilMethods.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 21/7/24.
//

import Foundation

func getMissingValidation(str: String) -> [String] {
    var errors: [String] = []
    if !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: str) {
        errors.append("least one uppercase")
    }

    if !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: str) {
        errors.append("least one digit")
    }

    if !NSPredicate(format: "SELF MATCHES %@", ".*[!&^%$#@()/]+.*").evaluate(with: str) {
        errors.append("least one symbol")
    }

    if !NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: str) {
        errors.append("least one lowercase")
    }

    if str.count < 8 {
        errors.append("min 8 characters total")
    }
    return errors
}
