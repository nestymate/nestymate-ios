//
//  LogoutService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 16/9/24.
//

import Foundation

class LogoutService {
    func shouldLogout(statusCode: Int?) -> Bool {
        statusCode == 403
    }
}
