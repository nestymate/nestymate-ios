//
//  LogoutService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 16/9/24.
//

import Foundation

final class LogoutService: Sendable {
    func shouldLogout(error: HttpError?) -> Bool {
        error == .tokenExpired
    }
}
