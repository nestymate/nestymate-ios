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
    @Published var homes: [Home] = []
    private let useCase: HomeUseCase
    private let logoutService: LogoutService

    init(useCase: HomeUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    @MainActor
    public func getHomes() async throws {
        shouldShowLoader = true
        do {
            let response = try await useCase.getAllHomes()
            shouldShowLoader = false
            homes = response.homes ?? []
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
    }

    @MainActor
    public func delete(at offsets: IndexSet) async throws {
        guard let index = offsets.first else { return }
        let homeToBeDelete = homes[index]
        homes.remove(at: index)
        shouldShowLoader = true
        do {
            _ = try await useCase.deleteHome(home: homeToBeDelete)
            try await getHomes()
            shouldShowLoader = false
        } catch {
            homes.insert(homeToBeDelete, at: index)
            self.error = error as? HttpError
        }
        shouldShowLoader = false
    }
}
