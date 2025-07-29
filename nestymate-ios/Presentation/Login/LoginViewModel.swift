//
//  LoginViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
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

    @MainActor
    public func login() async throws -> Home? {
        if useCase.loginValid(isUsernameValid: username.onValidate(), isPasswordValid: password.onValidate()) {
            shouldShow = true
            let errorLogin = try await useCase.login(username: username.value, password: password.value)
            let responseHome = try await useCase.checkHomeForUser()
            shouldShow = false
            let apiError = errorLogin ?? responseHome.error ?? nil
            error = apiError
            if apiError == nil {
                HomeUserDefaults().saveHome(with: responseHome.home?.id)
                return responseHome.home
            }
        }
        return nil
    }
}
