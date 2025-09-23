//
//  CategoriesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

final class CategoriesViewModel: ObservableObject {
    @Published public var shouldShowLoader: Bool?
    @Published var error: HttpError?
    @Published var categories: [Category] = []
    private let useCase: CategoryUseCase
    private let homeUseCase: HomeUseCase
    private let logoutService: LogoutService

    init(
        useCase: CategoryUseCase,
        homeUseCase: HomeUseCase,
        logoutService: LogoutService
    ) {
        self.useCase = useCase
        self.homeUseCase = homeUseCase
        self.logoutService = logoutService
    }

    @MainActor
    public func getCategories() async throws {
        shouldShowLoader = true
        do {
            let responseHome = try await homeUseCase.getActiveHome()
            let homeId = responseHome.home?.id ?? -1
            let response = try await useCase.getCategories(homeId: homeId)
            shouldShowLoader = false
            categories = response.categories ?? []
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
    }

    @MainActor
    public func delete(at offsets: IndexSet) async throws {
        guard let index = offsets.first else { return }
        let categoryToBeDelete = categories[index]
        categories.remove(at: index)

        shouldShowLoader = true
        do {
            let responseHome = try await homeUseCase.getActiveHome()
            let homeId = responseHome.home?.id ?? -1
            _ = try await useCase.deleteCategory(homeId: homeId, category: categoryToBeDelete)
            try await getCategories()
            shouldShowLoader = false
        } catch {
            categories.insert(categoryToBeDelete, at: index)
            self.error = error as? HttpError
        }
        shouldShowLoader = false
    }
}
