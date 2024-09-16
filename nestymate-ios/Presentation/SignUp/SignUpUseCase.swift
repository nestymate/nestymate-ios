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
    func checkHomeForUser(completionHandler: @escaping (Home?, Error?, Int?) -> Void)
}

class SignUpUseCaseImpl: SignUpUseCase {
    let service: LoginService
    let homeService: HomeService

    init(service: LoginService, homeService: HomeService) {
        self.service = service
        self.homeService = homeService
    }

    func isSignupValid(user: User) -> Bool {
        user.isValid && user.isPasswordsTheSame
    }

    func signUp(user: User, completionHandler: @escaping (Error?) -> Void) {
        service.signup(user: user, completionHandler: completionHandler)
    }

    func checkHomeForUser(completionHandler: @escaping (Home?, Error?, Int?) -> Void) {
        homeService.getHome(completionHandler: completionHandler)
    }
}
