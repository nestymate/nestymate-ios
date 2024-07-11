//
//  FieldType.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 12/7/24.
//

import Foundation

protocol FielValidatorProtocol {
    func validate(value: String) -> String?
}

enum FieldType: FielValidatorProtocol {
    case email
    case username
    case repeatPassword
    case password
    case name
    case description
    case address

    var placeHolder: String {
        switch self {
        case .email:
            return "Email"
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
        }
    }

    func validate(value: String) -> String? {
        switch self {
        case .email:
            return !value.isValidEmail ? "Enter a valid email" : nil
        case .username:
            return value.isEmpty ? "The username can not be empty" : nil
        case .password:
            return value.isEmpty ? "The password can not be empty" : nil
        case .name:
            return value.isEmpty ? "The name can not be empty" : nil
        case .description:
            return value.isEmpty ? "The description can not be empty" : nil
        case .address:
            return value.isEmpty ? "The adress can not be empty" : nil
        case .repeatPassword:
            return value.isEmpty ? "The password can not be empty" : nil
        }
    }
}
