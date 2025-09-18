//
//  HomesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 18/9/25.
//

import Foundation

final class HomesViewModel: ObservableObject {
    @Published public var shouldShowLoader: Bool?
    @Published var error: HttpError?
    private let useCase: HomeUseCase
    private let logoutService: LogoutService

    init(useCase: HomeUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    @MainActor
    public func getHomes() async throws -> [Home]? {
        shouldShowLoader = true
        do {
            let response = try await useCase.getAllHomes()
            shouldShowLoader = false
            return response.homes
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return nil
    }

    @MainActor
    public func delete(homeToBeDelete: Home) async throws -> [Home]? {
        shouldShowLoader = true
        do {
            _ = try await useCase.deleteHome(home: homeToBeDelete)
            let homes = try await getHomes()
            shouldShowLoader = false
            return homes
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return nil
    }
}
