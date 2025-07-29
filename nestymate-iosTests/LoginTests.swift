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

    @MainActor @Test func successfulLoginHasHome() async {
        let response = try? await useCase.login(username: "selini", password: "Sadface123!")
        #expect(response == nil)
    }

    @MainActor @Test func unsuccessfulLogin() async {
        let response = try? await useCaseFailed.login(username: "", password: "")
        #expect(response != nil)
    }

    @MainActor @Test func successfulCheckHomeForUser() async {
        let response = try? await useCase.checkHomeForUser()
        #expect(response?.home != nil)
    }

    @MainActor @Test func unsuccessfulCheckHomeForUser() async {
        let response = try? await useCaseFailed.checkHomeForUser()
        #expect(response?.error != nil)
    }
}
