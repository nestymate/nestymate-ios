//
//  CategoriesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

final class CategoriesViewModel: ObservableObject {
    @Published public var shouldShowLoader: Bool?
    @Published var error: Error?
    private let useCase: CategoryUseCase
    private let logoutService: LogoutService

    init(useCase: CategoryUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    @MainActor
    public func getCategories() async throws -> CategoriesResponse {
        shouldShowLoader = true
        let response = try await useCase.getCategories()
        shouldShowLoader = false
        let shouldLogout = logoutService.shouldLogout(statusCode: response.statusCode)
        return CategoriesResponse(
            categories: response.categories,
            statusCode: nil,
            shouldLogout: shouldLogout
        )
    }

    @MainActor
    public func delete(categoryToBeDelete: Category) async throws -> CategoriesResponse {
        shouldShowLoader = true
        _ = try await useCase.deleteCategory(category: categoryToBeDelete)
        shouldShowLoader = false
        error = error
        return try await getCategories()
    }
}
