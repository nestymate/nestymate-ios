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

    @Test func successfulGetHome() async {
        let response = try? await useCase.getHome()
        #expect(response?.error == nil)
    }

    @Test func unsuccessfulGetHome() async {
        let response = try? await useCaseFailed.getHome()
        #expect(response?.error != nil)
    }

    @Test func successfulEditHome() async {
        let response = try? await useCase.editHome(home: HomeTestsData.home)
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulEditHome() async {
        let response = try? await useCaseFailed.editHome(home: HomeTestsData.home)
        #expect(response?.error != nil)
    }

    @Test func successfulCreateHome() async {
        let response = try? await useCase.createHome(home: HomeTestsData.home)
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulCreateHome() async {
        let response = try? await useCaseFailed.createHome(home: HomeTestsData.home)
        #expect(response?.error != nil)
    }

    @Test func successfulInviteUserToHome() async {
        let response = try? await useCase.inviteUserToHome(email: "test")
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulInviteUserToHome() async {
        let response = try? await useCaseFailed.inviteUserToHome(email: "test")
        #expect(response?.error != nil)
    }
}
