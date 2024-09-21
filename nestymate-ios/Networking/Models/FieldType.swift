//
//  FieldType.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 12/7/24.
//

import Foundation

protocol FieldValidatorProtocol {
    func validate(value: String) -> String?
}

enum FieldType: FieldValidatorProtocol {
    case username
    case repeatPassword
    case password
    case name
    case surname
    case description
    case address
    case gender
    case birthday
    case amount
    case email

    var placeHolder: String {
        switch self {
        case .username:
            return String(localized: "username")
        case .password:
            return String(localized: "password")
        case .name:
            return String(localized: "name")
        case .description:
            return String(localized: "description")
        case .address:
            return String(localized: "address")
        case .repeatPassword:
            return String(localized: "repeat_password")
        case .surname:
            return String(localized: "surname")
        case .gender:
            return String(localized: "gender")
        case .birthday:
            return String(localized: "birthday")
        case .amount:
            return String(localized: "amount")
        case .email:
            return String(localized: "email")
        }
    }

    func validate(value: String) -> String? {
        return value.isEmpty ? String(localized: "fieldTypeEmptyMessage") : nil
    }

    func validate(value: Date) -> String? {
        return value == .now ? String(localized: "fieldTypeEmptDateyMessage") : nil
    }
}
