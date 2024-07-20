//
//  SignUpUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import Foundation
import SwiftUI

protocol SignUpUseCase {
    func isSignupValid(user: User) -> Bool
    func signUp(user: User, completionHandler: @escaping (Error?) -> Void)
}

class SignUpUseCaseImpl: SignUpUseCase {
    let service: LoginService
    init(service: LoginService) {
        self.service = service
    }

    func isSignupValid(user: User) -> Bool {
        user.isValid && user.isPasswordsTheSame
    }

    func signUp(user: User, completionHandler: @escaping (Error?) -> Void) {
        service.signup(user: user, completionHandler: completionHandler)
    }
}
