//
//  HttpError.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 17/7/24.
//

import Foundation
import SwiftUI

public enum HttpError: Error, Sendable, Equatable, Identifiable {
    case noNetwork
    case badServerResponse
    case fillAllValues
    case passwordDoNotMatch
    case passwordNotValid
    case birthdayNotValid
    case passwordAndUserNameDidNotMatch
    case requestFailed(error: Error)
    case errorToHandle(error: ErrorToHandle)
    case tokenExpired
    case unknown

    public var id: String {
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
        case .tokenExpired:
            "tokenExpired"
        }
    }

    public static func == (lhs: HttpError, rhs: HttpError) -> Bool {
        lhs.id == rhs.id
    }
}
