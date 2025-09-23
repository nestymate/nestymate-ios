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
    case date

    var placeHolder: String {
        switch self {
        case .username:
            String(localized: "username")
        case .password:
            String(localized: "password")
        case .name:
            String(localized: "name")
        case .description:
            String(localized: "description")
        case .address:
            String(localized: "address")
        case .repeatPassword:
            String(localized: "repeat_password")
        case .surname:
            String(localized: "surname")
        case .gender:
            String(localized: "gender")
        case .birthday:
            String(localized: "birthday")
        case .amount:
            String(localized: "amount")
        case .email:
            String(localized: "email")
        case .date:
            String(localized: "date")
        }
    }

    func validate(value: String) -> String? {
        value.isEmpty ? String(localized: "fieldTypeEmptyMessage") : nil
    }

    func validate(value: Date) -> String? {
        value == .now ? String(localized: "fieldTypeEmptDateyMessage") : nil
    }
}
