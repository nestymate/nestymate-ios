//
//  SignUpTests.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 27/12/24.
//

import Testing

@testable import nestymate_ios

var useCase: SignUpUseCase {
    SignUpUseCaseImpl(service: LoginServiceMock(), homeService: HomeServiceMock(hasHome: true))
}

var useCaseFailed: SignUpUseCase {
    SignUpUseCaseImpl(service: LoginServiceFailedMock(), homeService: HomeServiceFailedMock())
}

class SignUpTests {
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

    @Test func successfulSignUp() {
        useCase.signUp(user: SignUpTestsData.correctUser) { error in
            #expect(error == nil)
        }
    }

    @Test func unsuccessfulSignUp() {
        useCaseFailed.signUp(user: SignUpTestsData.correctUser) { error in
            #expect(error != nil)
        }
    }

    @Test func checkHomeForUserSuccessfully() {
        useCase.checkHomeForUser { home, error, _ in
            #expect(home != nil)
            #expect(error == nil)
        }
    }

    @Test func checkHomeForUserUnsuccessfully() {
        useCaseFailed.checkHomeForUser { home, _, error in
            #expect(home == nil)
            #expect(error != nil)
        }
    }
}
