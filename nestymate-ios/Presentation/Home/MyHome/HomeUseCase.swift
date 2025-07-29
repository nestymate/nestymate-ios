//
//  HomeUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

protocol HomeUseCase: Sendable {
    func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool
    func getHome() async throws -> HomeResponse
    func editHome(home: Home) async throws -> GenericResponse
    func createHome(home: Home) async throws -> GenericResponse
    func inviteUserToHome(email: String) async throws -> GenericResponse
}

final class HomeUseCaseImpl: HomeUseCase {
    let homeService: HomeService

    init(homeService: HomeService) {
        self.homeService = homeService
    }

    nonisolated func createValid(isNameValid: Bool, isDescriptionValid: Bool, isAddressValid: Bool) -> Bool {
        isNameValid && isDescriptionValid && isAddressValid
    }

    func getHome() async throws -> HomeResponse {
        try await homeService.getHome()
    }

    func editHome(home: Home) async throws -> GenericResponse {
        try await homeService.editHome(home: home)
    }

    func createHome(home: Home) async throws -> GenericResponse {
        try await homeService.createHome(home: home)
    }

    func inviteUserToHome(email: String) async throws -> GenericResponse {
        try await homeService.inviteUserToHome(email: email)
    }
}
