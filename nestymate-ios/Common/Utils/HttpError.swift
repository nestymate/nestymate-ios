//
//  HttpError.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 17/7/24.
//

import Foundation
import SwiftUI

enum HttpError: Error, Sendable, Equatable, Identifiable {
    case noNetwork
    case badServerResponse
    case fillAllValues
    case passwordDoNotMatch
    case passwordNotValid
    case birthdayNotValid
    case passwordAndUserNameDidNotMatch
    case requestFailed(error: Error)
    case errorToHandle(error: ErrorToHandle)
    case unknown

    var id: String {
        switch self {
        case .noNetwork:
            "noNetwork"
        case .badServerResponse:
            "badServerResponse"
        case .fillAllValues:
            "fillAllValues"
        case .passwordDoNotMatch:
            "passwordDoNotMatch"
        case .passwordNotValid:
            "passwordNotValid"
        case .birthdayNotValid:
            "birthdayNotValid"
        case .passwordAndUserNameDidNotMatch:
            "requestFailed"
        case .requestFailed:
            "requestFailed"
        case .errorToHandle:
            "errorToHandle"
        case .unknown:
            "unknown"
        }
    }

    var alert: Alert {
        switch self {
        case .noNetwork:
            Alert(title: Text(String(localized: "no_internet")))
        case .badServerResponse, .unknown:
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
        case let .errorToHandle(error: error):
            Alert(title: Text(error.title), message: Text(error.detail))
        }
    }

    static func == (lhs: HttpError, rhs: HttpError) -> Bool {
        lhs.id == rhs.id
    }
}
