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
    @Published var buttonTitle: String = ""
    @Published var pageTitle: String = ""
    private let categoryId: Int?
    private var category: Category?

    init(
        categoryId: Int?,
        useCase: CategoryUseCase,
        homeUseCase: HomeUseCase,
        logoutService: LogoutService
    ) {
        isEdit = categoryId != nil
        self.categoryId = categoryId
        self.useCase = useCase
        self.homeUseCase = homeUseCase
        self.logoutService = logoutService
        setupCategory()
        setupTitles()
    }

    var shouldEnableButton: Bool {
        !name.value.isEmpty && !description.value.isEmpty
    }

    private func setupCategory() {
        guard isEdit, let category else { return }
        name = .init(value: category.name, fieldType: .name)
        description = .init(value: category.description ?? "", fieldType: .description)
    }

    private func setupTitles() {
        buttonTitle = isEdit ? String(localized: "update") : String(localized: "save")
        pageTitle = isEdit ? String(localized: "edit_category") : String(localized: "create_category")
    }

    @MainActor
    public func getCategory() async throws -> Bool {
        guard let categoryId else { return false }
        shouldShowLoader = true
        do {
            let response = try await useCase.getCategory(categoryId: categoryId)
            category = response.category
            setupCategory()
            setupTitles()
            shouldShowLoader = false
            return response.shouldLogout
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return false
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
                name: name.value,
                description: description.value
            )
            do {
                let responseHome = try await homeUseCase.getActiveHome()
                let homeId = responseHome.home?.id ?? -1
                if isEdit {
                    _ = try await useCase.editCategory(homeId: homeId, category: category)
                    shouldShowLoader = false
                } else {
                    _ = try await useCase.createCategory(homeId: homeId, category: category)
                    shouldShowLoader = false
                }
            } catch {
                self.error = error as? HttpError
            }
        }
        shouldShowLoader = false
        return false
    }
}
