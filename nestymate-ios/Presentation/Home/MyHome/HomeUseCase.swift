//
//  HomeUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

protocol HomeUseCase: Sendable {
    func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool
    func getActiveHome() async throws -> HomeResponse
    func editHome(home: Home) async throws -> GenericResponse
    func createHome(home: Home) async throws -> GenericResponse
    func inviteUserToHome(homeId: Int, email: String) async throws -> GenericResponse
    func acceptInvite(inviteCode: String) async throws -> GenericResponse
}

final class HomeUseCaseImpl: HomeUseCase {
    let homeService: HomeService

    init(homeService: HomeService) {
        self.homeService = homeService
    }

    nonisolated func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool {
        isNameValid && isDescriptionValid && isAddressValid
    }

    func getActiveHome() async throws -> HomeResponse {
        try await homeService.getActiveHome()
    }

    func editHome(home: Home) async throws -> GenericResponse {
        try await homeService.editHome(home: home)
    }

    func createHome(home: Home) async throws -> GenericResponse {
        try await homeService.createHome(home: home)
    }

    func inviteUserToHome(homeId: Int, email: String) async throws -> GenericResponse {
        try await homeService.inviteUserToHome(homeId: homeId, email: email)
    }

    func acceptInvite(inviteCode: String) async throws -> GenericResponse {
        try await homeService.acceptInvite(inviteCode: inviteCode)
    }
}
