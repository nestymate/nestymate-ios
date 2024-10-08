//
//  CreateOrEditCategoryViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

class CreateOrEditCategoryViewModel: ObservableObject {
    private let useCase: CategoryUseCase
    private let logoutService: LogoutService
    @Published public var name: FieldModel = .init(value: "", fieldType: .name)
    @Published public var description: FieldModel = .init(value: "", fieldType: .description)
    @Published public var shouldShowLoader: Bool?
    @Published var isEdit: Bool = false
    @Published var error: Error?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    private var category: Category?

    init(category: Category?, useCase: CategoryUseCase, logoutService: LogoutService) {
        isEdit = category != nil
        self.category = category
        self.useCase = useCase
        self.logoutService = logoutService
        setupExpense()
        setupTitles()
    }

    var shouldEnableButton: Bool {
        !name.value.isEmpty && !description.value.isEmpty
    }

    func setupExpense() {
        guard isEdit, let category else { return }
        name = .init(value: category.name, fieldType: .name)
        description = .init(value: category.description, fieldType: .description)
    }

    func createOrUpdateExpense(completionHandler: @escaping (Bool?) -> Void) {
        if useCase.createValid(
            isNameValid: name.onValidate(),
            isDescriptionValid: description.onValidate()
        ) {
            shouldShowLoader = true
            let category = Category(
                id: category?.id ?? 0,
                code: category?.code ?? "",
                name: name.value,
                description: description.value
            )
            if isEdit {
                useCase.editCategory(category: category) { [weak self] error, statusCode in
                    self?.shouldShowLoader = false
                    self?.error = error
                    completionHandler(self?.logoutService.shouldLogout(statusCode: statusCode))
                }
            } else {
                useCase.createCategory(category: category) { [weak self] error, statusCode in
                    self?.shouldShowLoader = false
                    self?.error = error
                    completionHandler(self?.logoutService.shouldLogout(statusCode: statusCode))
                }
            }
        }
    }

    private func setupTitles() {
        buttonTitle = isEdit ? String(localized: "update") : String(localized: "save")
        pageTitle = isEdit ? String(localized: "edit_category") : String(localized: "create_category")
    }
}
