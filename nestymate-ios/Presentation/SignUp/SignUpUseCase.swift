//
//  SignUpUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import Foundation
import SwiftUI

protocol SignUpUseCase: Sendable {
    func shouldProceedToSignUp(user: User) -> SuccessResponse
    func signUp(user: User) async throws -> HttpError?
    func checkHomeForUser() async throws -> HomeResponse
}

final class SignUpUseCaseImpl: SignUpUseCase {
    let service: LoginService
    let homeService: HomeService

    init(service: LoginService, homeService: HomeService) {
        self.service = service
        self.homeService = homeService
    }

    func shouldProceedToSignUp(user: User) -> SuccessResponse {
        if !user.isPasswordValid {
            return SuccessResponse(success: false, error: .passwordNotValid)
        } else if !user.isPasswordsTheSame {
            return SuccessResponse(success: false, error: .passwordDoNotMatch)
        } else if user.birthday == DateUtils.getToday() {
            return SuccessResponse(success: false, error: .birthdayNotValid)
        } else if !user.isValid {
            return SuccessResponse(success: false, error: .fillAllValues)
        }
        return SuccessResponse(success: true, error: nil)
    }

    func signUp(user: User) async throws -> HttpError? {
        try await service.signup(user: user)
    }

    func checkHomeForUser() async throws -> HomeResponse {
        try await homeService.getActiveHome()
    }
}
