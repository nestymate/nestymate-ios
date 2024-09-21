//
//  Error.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 17/7/24.
//

import Foundation
import SwiftUI

enum Error: Identifiable {
    var id: Self { return self }

    case noNetwork
    case badServerResponse
    case fillAllValues
    case passwordDoNotMatch
    case passwordNotValid
    case birthdayNotValid

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
        }
    }
}
