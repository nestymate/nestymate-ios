//
//  CategoryViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

class CategoryViewModel: ObservableObject {
    let useCase: CategoryUseCase
    @Published public var shouldShowLoader: Bool?
    @Published var error: Error?
    private var categories: [Category]?

    init(useCase: CategoryUseCase) {
        self.useCase = useCase
    }

    public func getCategories(completionHandler: @escaping ([Category]) -> Void) {
        shouldShowLoader = true
        useCase.getCategory { [weak self] categories, error in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            self.categories = categories
            completionHandler(categories)
        }
    }

    public func delete(at offset: IndexSet) {
        categories?.remove(atOffsets: offset)
    }
}
