//
//  CreateCategoryViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

class CreateCategoryViewModel: ObservableObject {
    let useCase: CategoryUseCase
    @Published public var name: FieldModel = .init(value: "", fieldType: .name)
    @Published public var shouldShowLoader: Bool?
    @Published var error: Error?

    init(useCase: CategoryUseCase) {
        self.useCase = useCase
    }

    public func createCategory(completionHandler: @escaping () -> Void) {
        shouldShowLoader = true
        useCase.createCategory { [weak self] error in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            completionHandler()
        }
    }
}
