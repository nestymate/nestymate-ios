//
//  CategoriesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    @Published public var shouldShowLoader: Bool?
    @Published var error: Error?
    @Published var categories: [Category] = []
    private let useCase: CategoryUseCase
    private let logoutService: LogoutService

    init(useCase: CategoryUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    public func getCategories(completionHandler: @escaping (Bool) -> Void) {
        shouldShowLoader = true
        useCase.getCategories { [weak self] _, error, statusCode in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            self.categories = categories
            completionHandler(logoutService.shouldLogout(statusCode: statusCode))
        }
    }

    public func delete(at offset: IndexSet, completionHandler: @escaping (Bool) -> Void) {
        let index = offset[offset.startIndex]
        shouldShowLoader = true
        let categoryToBeDelete = categories[index]
        useCase.deleteCategory(category: categoryToBeDelete) { [weak self] error, _ in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            getCategories(completionHandler: completionHandler)
        }
    }
}
