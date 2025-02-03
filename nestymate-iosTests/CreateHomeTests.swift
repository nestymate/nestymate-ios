//
//  CreateHomeTests.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 3/2/25.
//

@testable import nestymate_ios
import Testing

class CreateHomeTests {
    private var useCase: HomeUseCase {
        HomeUseCaseImpl(homeService: HomeServiceMock(hasHome: false))
    }

    private var useCaseFailed: HomeUseCase {
        HomeUseCaseImpl(homeService: HomeServiceFailedMock())
    }

    @Test func createValid() {
        #expect(useCase.createValid(
            isNameValid: true,
            isDescriptionValid: true,
            isAddressValid: true
        ))
    }

    @Test func successfulGetHome() {
        useCase.getHome { _, error, _ in
            #expect(error == nil)
        }
    }

    @Test func unsuccessfulGetHome() {
        useCaseFailed.getHome { _, error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulEditHome() {
        useCase.editHome(home: HomeTestsData.home) { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulEditHome() {
        useCaseFailed.editHome(home: HomeTestsData.home) { error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulCreateHome() {
        useCase.createHome(home: HomeTestsData.home) { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulCreateHome() {
        useCaseFailed.createHome(home: HomeTestsData.home) { error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulInviteUserToHome() {
        useCase.inviteUserToHome(email: "test") { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulInviteUserToHome() {
        useCaseFailed.inviteUserToHome(email: "test") { error, _ in
            #expect(error != nil)
        }
    }
}
