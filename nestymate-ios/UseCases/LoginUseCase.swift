//
//  LoginUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Foundation

protocol LoginUseCase {
    func login(username: String, password: String, completionHandler: @escaping () -> Void)
    func checkHomeForUser(completionHandler: @escaping (Home?) -> Void)
}

class LoginUseCaseImpl: LoginUseCase {
    let service: LoginService = LoginServiceImpl()
    let homeService: HomeService = HomeServiceImpl()
    func login(username: String, password: String, completionHandler: @escaping () -> Void) {
        service.login(username: username, password: password, completionHandler: completionHandler)
    }

    func checkHomeForUser(completionHandler: @escaping (Home?) -> Void) {
        homeService.getHome(completionHandler: completionHandler)
    }
}
