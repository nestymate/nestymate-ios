//
//  LoginViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    let useCase: LoginUseCase = LoginUseCaseImpl()
    @Published public var username: FieldModel = .init(value: "test123", fieldType: .username)
    @Published public var password: FieldModel = .init(value: "test321", fieldType: .password)
    @Published public var shouldShow: Bool?
    @Published var error: Error?

    @MainActor public func login(completionHandler: @escaping (Home?) -> Void) {
        if useCase.loginValid(isUsernameValid: username.onValidate(), isPasswordValid: password.onValidate()) {
            shouldShow = true
            useCase.login(username: username.value, password: password.value) { [weak self] errorLogin in
                self?.useCase.checkHomeForUser { [weak self] home, errorCheckHome in
                    self?.shouldShow = false
                    let apiError = errorLogin ?? errorCheckHome ?? nil
                    self?.error = apiError
                    if apiError == nil {
                        completionHandler(home)
                    }
                }
            }
        }
    }
}
