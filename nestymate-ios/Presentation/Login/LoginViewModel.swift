//
//  LoginViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    let useCase: LoginUseCase
    @Published public var username: FieldModel = .init(value: "Kyriaz", fieldType: .username)
    @Published public var password: FieldModel = .init(value: "Sadface123!", fieldType: .password)
    @Published public var shouldShow: Bool?
    @Published var error: Error?

    var shouldEnableButton: Bool {
        !username.value.isEmpty && !password.value.isEmpty
    }

    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }

    @MainActor public func login(completionHandler: @escaping (Home?) -> Void) {
        if useCase.loginValid(isUsernameValid: username.onValidate(), isPasswordValid: password.onValidate()) {
            shouldShow = true
            useCase.login(username: username.value, password: password.value) { [weak self] errorLogin in
                self?.useCase.checkHomeForUser { [weak self] home, errorCheckHome, _ in
                    self?.shouldShow = false
                    let apiError = errorLogin ?? errorCheckHome ?? nil
                    self?.error = apiError
                    if apiError == nil {
                        HomeUserDefaults().saveHome(with: home?.id)
                        completionHandler(home)
                    }
                }
            }
        }
    }
}
