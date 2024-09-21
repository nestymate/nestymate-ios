//
//  SignUpUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import Foundation
import SwiftUI

protocol SignUpUseCase {
    func shouldProceedToSignUp(user: User) -> (Bool, Error?)
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

    func shouldProceedToSignUp(user: User) -> (Bool, Error?) {
        if !user.isPasswordValid {
            return (false, .passwordNotValid)
        } else if !user.isPasswordsTheSame {
            return (false, .passwordDoNotMatch)
        } else if user.birthday == DateUtils.getToday() {
            return (false, .birthdayNotValid)
        } else if !user.isValid {
            return (false, .fillAllValues)
        }
        return (true, nil)
    }

    func signUp(user: User, completionHandler: @escaping (Error?) -> Void) {
        service.signup(user: user, completionHandler: completionHandler)
    }

    func checkHomeForUser(completionHandler: @escaping (Home?, Error?, Int?) -> Void) {
        homeService.getHome(completionHandler: completionHandler)
    }
}
