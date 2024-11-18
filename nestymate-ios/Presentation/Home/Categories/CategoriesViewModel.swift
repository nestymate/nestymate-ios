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
    private let useCase: CategoryUseCase
    private let logoutService: LogoutService

    init(useCase: CategoryUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    public func getCategories(completionHandler: @escaping ([Category]?, Bool) -> Void) {
        shouldShowLoader = true
        useCase.getCategories { [weak self] categories, error, statusCode in
            guard let self else { return }
            shouldShowLoader = false
            self.error = error
            completionHandler(categories, logoutService.shouldLogout(statusCode: statusCode))
        }
    }

    public func delete(categoryToBeDelete: Category, completionHandler: @escaping ([Category]?, Bool) -> Void) {
        shouldShowLoader = true
        useCase.deleteCategory(category: categoryToBeDelete) { [weak self] error, _ in
            guard let self else { return }
            shouldShowLoader = false
            self.error = error
            getCategories(completionHandler: completionHandler)
        }
    }
}
