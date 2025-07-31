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
    @Published var error: HttpError?

    var shouldEnableButton: Bool {
        !username.value.isEmpty && !password.value.isEmpty
    }

    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }

    @MainActor
    public func login() async throws -> LoginResponse {
        if useCase.loginValid(isUsernameValid: username.onValidate(), isPasswordValid: password.onValidate()) {
            shouldShow = true
            do {
                _ = try await useCase.login(username: username.value, password: password.value)
                let responseHome = try await useCase.checkHomeForUser()
                HomeUserDefaults().saveHome(with: responseHome.home?.id)
                return LoginResponse(success: true, shouldShowHome: responseHome.home == nil)
            } catch {
                self.error = error as? HttpError
            }
        }
        shouldShow = false
        return LoginResponse(success: false, shouldShowHome: false)
    }
}
