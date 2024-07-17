//
//  LoginUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Foundation

protocol LoginUseCase {
    func loginValid(isUsernameValid: Bool, isPasswordValid: Bool) -> Bool
    func login(username: String, password: String, completionHandler: @escaping (Error?) -> Void)
    func checkHomeForUser(completionHandler: @escaping (Home?, Error?) -> Void)
}

class LoginUseCaseImpl: LoginUseCase {
    let service: LoginService = LoginServiceImpl()
    let homeService: HomeService = HomeServiceImpl()

    func loginValid(isUsernameValid: Bool, isPasswordValid: Bool) -> Bool {
        isUsernameValid && isPasswordValid
    }

    func login(username: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        service.login(username: username, password: password, completionHandler: completionHandler)
    }

    func checkHomeForUser(completionHandler: @escaping (Home?, Error?) -> Void) {
        homeService.getHome(completionHandler: completionHandler)
    }
}
