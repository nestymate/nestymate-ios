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
    let homeUseCase: HomeUseCase
    @Published public var username: FieldModel = .init(value: "Kyriaz", fieldType: .username)
    @Published public var password: FieldModel = .init(value: "Sadface123!", fieldType: .password)
    @Published public var shouldShow: Bool?
    @Published var error: HttpError?

    var shouldEnableButton: Bool {
        !username.value.isEmpty && !password.value.isEmpty
    }

    init(useCase: LoginUseCase, homeUseCase: HomeUseCase) {
        self.useCase = useCase
        self.homeUseCase = homeUseCase
    }

    func save(inviteCode: String) {
        UserDefaults.standard.set(inviteCode, forKey: "inviteCode")
    }

    @MainActor
    public func login() async throws -> LoginResponse {
        if useCase.loginValid(isUsernameValid: username.onValidate(), isPasswordValid: password.onValidate()) {
            shouldShow = true
            do {
                _ = try await useCase.login(username: username.value, password: password.value)
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                let responseHome = try await homeUseCase.getActiveHome()
                return LoginResponse(success: true, shouldShowHome: responseHome.home == nil)
            } catch {
                self.error = error as? HttpError
            }
        }
        shouldShow = false
        return LoginResponse(success: false, shouldShowHome: false)
    }
}
