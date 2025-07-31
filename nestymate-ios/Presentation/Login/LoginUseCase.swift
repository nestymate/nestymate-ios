//
//  LoginUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Foundation

protocol LoginUseCase: Sendable {
    func loginValid(isUsernameValid: Bool, isPasswordValid: Bool) -> Bool
    func login(username: String, password: String) async throws -> HttpError?
    func checkHomeForUser() async throws -> HomeResponse
}

final class LoginUseCaseImpl: LoginUseCase {
    let service: LoginService
    let homeService: HomeService

    init(service: LoginService, homeService: HomeService) {
        self.service = service
        self.homeService = homeService
    }

    func loginValid(isUsernameValid: Bool, isPasswordValid: Bool) -> Bool {
        isUsernameValid && isPasswordValid
    }

    @MainActor
    func login(username: String, password: String) async throws -> HttpError? {
        try await service.login(username: username, password: password)
    }

    @MainActor
    func checkHomeForUser() async throws -> HomeResponse {
        try await homeService.getHome()
    }
}
