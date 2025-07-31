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
    private let logoutService: LogoutService

    init(useCase: CategoryUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    @MainActor
    public func getCategories() async throws -> CategoriesResponse? {
        shouldShowLoader = true
        do {
            let response = try await useCase.getCategories()
            return CategoriesResponse(
                categories: response.categories,
                statusCode: nil,
                shouldLogout: logoutService.shouldLogout(statusCode: response.statusCode)
            )
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return nil
    }

    @MainActor
    public func delete(categoryToBeDelete: Category) async throws -> CategoriesResponse? {
        shouldShowLoader = true
        do {
            _ = try await useCase.deleteCategory(category: categoryToBeDelete)
            return try await getCategories()
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return nil
    }
}
