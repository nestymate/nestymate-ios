//
//  LoginTests.swift
//  NestymateTests
//
//  Created by Selini Kyriazidou on 18/4/24.
//

@testable import nestymate_ios
import Testing

class LoginTests {
    private var useCase: LoginUseCase {
        LoginUseCaseImpl(service: LoginServiceMock(), homeService: HomeServiceMock(hasHome: true))
    }

    private var useCaseNotHome: LoginUseCase {
        LoginUseCaseImpl(service: LoginServiceMock(), homeService: HomeServiceMock(hasHome: false))
    }

    private var useCaseFailed: LoginUseCase {
        LoginUseCaseImpl(service: LoginServiceFailedMock(), homeService: HomeServiceFailedMock())
    }

    @MainActor @Test func loginValid() {
        #expect(useCase.loginValid(isUsernameValid: true, isPasswordValid: true))
    }

    @MainActor @Test func loginNotValid() {
        #expect(!useCase.loginValid(isUsernameValid: false, isPasswordValid: true))
    }

    @MainActor @Test func successfulLoginHasHome() {
        useCase.login(username: "selini", password: "Sadface123!") { error in
            #expect(error == nil)
        }
    }

    @MainActor @Test func unsuccessfulLogin() {
        useCaseFailed.login(username: "", password: "") { error in
            #expect(error != nil)
        }
    }

    @MainActor @Test func successfulCheckHomeForUser() {
        useCase.checkHomeForUser { home, _, _ in
            #expect(home != nil)
        }
    }

    @MainActor @Test func unsuccessfulCheckHomeForUser() {
        useCaseFailed.checkHomeForUser { _, error, _ in
            #expect(error != nil)
        }
    }
}
