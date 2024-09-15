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

    var placeHolder: String {
        switch self {
        case .username:
            return "Username"
        case .password:
            return "Password"
        case .name:
            return "Name"
        case .description:
            return "Description"
        case .address:
            return "Address"
        case .repeatPassword:
            return "Repeat Password"
        case .surname:
            return "Surname"
        case .gender:
            return "Gender"
        case .birthday:
            return "Birthday"
        case .amount:
            return "Amount"
        }
    }

    func validate(value: String) -> String? {
        switch self {
        case .username:
            return value.isEmpty ? "The username can not be empty" : nil
        case .password:
            return value.isEmpty ? "The password can not be empty" : nil
        case .name:
            return value.isEmpty ? "The name can not be empty" : nil
        case .description:
            return value.isEmpty ? "The description can not be empty" : nil
        case .address:
            return value.isEmpty ? "The address can not be empty" : nil
        case .repeatPassword:
            return value.isEmpty ? "The password can not be empty" : nil
        case .surname:
            return value.isEmpty ? "The surname can not be empty" : nil
        case .gender:
            return value.isEmpty ? "Gender field can not be empty" : nil
        case .birthday:
            return value.isEmpty ? "Birthday field can not be empty" : nil
        case .amount:
            return value.isEmpty ? "Amount field can not be empty" : nil
        }
    }

    func validate(value: Date) -> String? {
        return value == .now ? "Birthday field can not be same as today" : nil
    }
}
