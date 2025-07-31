//
//  HttpError.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 17/7/24.
//

import Foundation
import SwiftUI

enum HttpError: Error, Sendable, Identifiable {
    var id: UUID { UUID() }
    case noNetwork
    case badServerResponse
    case fillAllValues
    case passwordDoNotMatch
    case passwordNotValid
    case birthdayNotValid
    case passwordAndUserNameDidNotMatch
    case requestFailed(error: Error)

    var alert: Alert {
        switch self {
        case .noNetwork:
            Alert(title: Text(String(localized: "no_internet")))
        case .badServerResponse:
            Alert(title: Text(String(localized: "error")))
        case .fillAllValues:
            Alert(title: Text(String(localized: "fill_all_fields")))
        case .passwordDoNotMatch:
            Alert(title: Text(String(localized: "password_not_match")))
        case .passwordNotValid:
            Alert(title: Text(String(localized: "password_not_valid")))
        case .birthdayNotValid:
            Alert(title: Text(String(localized: "fieldTypeEmptDateyMessage")))
        case .passwordAndUserNameDidNotMatch:
            Alert(title: Text(String(localized: "password_useraname_not_correcr")))
        case .requestFailed:
            Alert(title: Text(String(localized: "generic_error")))
        }
    }
}
