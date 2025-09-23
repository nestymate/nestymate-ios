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
    func getAllHomes() async throws -> HomesResponse
    func getHome(homeId: Int) async throws -> HomeResponse
    func createHome(home: Home) async throws -> GenericResponse
    func editHome(home: Home) async throws -> GenericResponse
    func deleteHome(home: Home) async throws -> GenericResponse
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

    func getAllHomes() async throws -> HomesResponse {
        try await homeService.getAllHomes()
    }

    func getHome(homeId: Int) async throws -> HomeResponse {
        try await homeService.getHome(homeId: homeId)
    }

    func createHome(home: Home) async throws -> GenericResponse {
        try await homeService.createHome(home: home)
    }

    func editHome(home: Home) async throws -> GenericResponse {
        try await homeService.editHome(home: home)
    }

    func deleteHome(home: Home) async throws -> GenericResponse {
        try await homeService.deleteHome(home: home)
    }

    func inviteUserToHome(homeId: Int, email: String) async throws -> GenericResponse {
        try await homeService.inviteUserToHome(homeId: homeId, email: email)
    }

    func acceptInvite(inviteCode: String) async throws -> GenericResponse {
        try await homeService.acceptInvite(inviteCode: inviteCode)
    }
}
