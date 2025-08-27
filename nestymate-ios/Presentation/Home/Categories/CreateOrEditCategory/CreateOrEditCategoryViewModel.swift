//
//  CreateOrEditCategoryViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

final class CreateOrEditCategoryViewModel: ObservableObject {
    private let useCase: CategoryUseCase
    private let homeUseCase: HomeUseCase
    private let logoutService: LogoutService
    @Published public var name: FieldModel = .init(value: "", fieldType: .name)
    @Published public var description: FieldModel = .init(value: "", fieldType: .description)
    @Published public var shouldShowLoader: Bool?
    @Published var isEdit: Bool = false
    @Published var error: HttpError?
    var buttonTitle: String = ""
    var pageTitle: String = ""
    private var category: Category?

    init(
        category: Category?,
        useCase: CategoryUseCase,
        homeUseCase: HomeUseCase,
        logoutService: LogoutService
    ) {
        isEdit = category != nil
        self.category = category
        self.useCase = useCase
        self.homeUseCase = homeUseCase
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

    @MainActor
    func createOrUpdateCategory() async throws -> Bool {
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
            do {
                let responseHome = try await homeUseCase.getActiveHome()
                let homeId = responseHome.home?.id ?? -1
                if isEdit {
                    let response = try await useCase.editCategory(homeId: homeId, category: category)
                    shouldShowLoader = false
                    return logoutService.shouldLogout(statusCode: response.statusCode)
                } else {
                    let response = try await useCase.createCategory(homeId: homeId, category: category)
                    shouldShowLoader = false
                    return logoutService.shouldLogout(statusCode: response.statusCode)
                }
            } catch {
                self.error = error as? HttpError
            }
        }
        shouldShowLoader = false
        return false
    }

    private func setupTitles() {
        buttonTitle = isEdit ? String(localized: "update") : String(localized: "save")
        pageTitle = isEdit ? String(localized: "edit_category") : String(localized: "create_category")
    }
}
