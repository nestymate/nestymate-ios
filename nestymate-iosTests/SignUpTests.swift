//
//  SignUpTests.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 27/12/24.
//

@testable import nestymate_ios
import Testing

class SignUpTests {
    private var useCase: SignUpUseCase {
        SignUpUseCaseImpl(service: LoginServiceMock(), homeService: HomeServiceMock(hasHome: true))
    }

    private var useCaseFailed: SignUpUseCase {
        SignUpUseCaseImpl(service: LoginServiceFailedMock(), homeService: HomeServiceFailedMock())
    }

    @Test func shouldProceedToSignUpCorrectUser() {
        let result = useCase.shouldProceedToSignUp(user: SignUpTestsData.correctUser)
        #expect(result.0)
    }

    @Test func shouldProceedToSignUpUnEmptyValuesUser() {
        let result = useCase.shouldProceedToSignUp(user: SignUpTestsData.emptyValuesUser)
        #expect(!result.0)
        let error: Error? = result.1
        #expect(error == .passwordNotValid)
    }

    @Test func shouldProceedToSignUpWeakPassword() {
        let result = useCase.shouldProceedToSignUp(user: SignUpTestsData.incorrectPasswordUser)
        #expect(!result.0)
        let error: Error? = result.1
        #expect(error == .passwordNotValid)
    }

    @Test func shouldProceedToSignUpNotMatchingPassword() {
        let result = useCase.shouldProceedToSignUp(user: SignUpTestsData.notMatchingPasswordUser)
        #expect(!result.0)
        let error: Error? = result.1
        #expect(error == .passwordDoNotMatch)
    }

    @Test func shouldProceedToSignUpIncorrectBirthday() {
        let result = useCase.shouldProceedToSignUp(user: SignUpTestsData.incorrectBirthdayUser)
        #expect(!result.0)
        let error: Error? = result.1
        #expect(error == .birthdayNotValid)
    }

    @Test func shouldProceedToSignUpUserIsInvalid() {
        let result = useCase.shouldProceedToSignUp(user: SignUpTestsData.emptyNameUser)
        #expect(!result.0)
        let error: Error? = result.1
        #expect(error == .fillAllValues)
    }

    @Test func successfulSignUp() async {
        let response = try? await useCase.signUp(user: SignUpTestsData.correctUser)
        #expect(response == nil)
    }

    @Test func unsuccessfulSignUp() async {
        let response = try? await useCaseFailed.signUp(user: SignUpTestsData.correctUser)
        #expect(response != nil)
    }

    @Test func checkHomeForUserSuccessfully() async {
        let response = try? await useCase.checkHomeForUser()
        #expect(response?.home != nil)
        #expect(response?.error == nil)
    }

    @Test func checkHomeForUserUnsuccessfully() async {
        let response = try? await useCaseFailed.checkHomeForUser()
        #expect(response?.home == nil)
        #expect(response?.error != nil)
    }
}
