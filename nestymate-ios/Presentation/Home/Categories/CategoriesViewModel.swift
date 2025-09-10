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
    public func getCategories() async throws -> [Category]? {
        shouldShowLoader = true
        do {
            let responseHome = try await homeUseCase.getActiveHome()
            let homeId = responseHome.home?.id ?? -1
            let response = try await useCase.getCategories(homeId: homeId)
            shouldShowLoader = false
            return response.categories
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return nil
    }

    @MainActor
    public func delete(categoryToBeDelete: Category) async throws -> [Category]? {
        shouldShowLoader = true
        do {
            let responseHome = try await homeUseCase.getActiveHome()
            let homeId = responseHome.home?.id ?? -1
            _ = try await useCase.deleteCategory(homeId: homeId, category: categoryToBeDelete)
            let categories = try await getCategories()
            shouldShowLoader = false
            return categories
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return nil
    }
}
