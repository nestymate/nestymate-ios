//
//  HttpError+Alert.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/9/25.
//

import SwiftUI

public func handleHttpErrorAlert(error: HttpError, action: @escaping () -> Void = {}) -> Alert {
    switch error {
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
    case .tokenExpired:
        Alert(
            title: Text(String(localized: "log_οut_error")),
            message: Text(""),
            dismissButton: .default(Text("OK")) {
                action()
            }
        )
    }
}
