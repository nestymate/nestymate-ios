//
//  LoginUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Foundation

protocol LoginUseCase {
    func login(username: String, password: String, completionHandler: @escaping () -> Void)
}

class LoginUseCaseImpl: LoginUseCase {
    let service: LoginService = LoginServiceImpl()
    func login(username: String, password: String, completionHandler: @escaping () -> Void) {
        service.login(username: username, password: password, completionHandler: completionHandler)
    }
}
