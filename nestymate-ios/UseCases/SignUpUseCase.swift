//
//  SignUpUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import Foundation
import SwiftUI

protocol SignUpUseCase {
    func signUpValid(isEmailValid: Bool, isPasswordValid: Bool, isRepeatPasswordValid: Bool) -> Bool
    func signUp(completionHandler: @escaping () -> Void)
}

class SignUpUseCaseImpl: SignUpUseCase {
    func signUpValid(isEmailValid: Bool, isPasswordValid: Bool, isRepeatPasswordValid: Bool) -> Bool {
        isEmailValid && isPasswordValid && isRepeatPasswordValid
    }

    let service: LoginService = LoginServiceImpl()
    func signUp(completionHandler: @escaping () -> Void) {
        // add service here
        completionHandler()
    }
}
