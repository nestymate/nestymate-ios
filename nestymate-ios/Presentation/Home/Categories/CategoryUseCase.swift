//
//  CategoryUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

protocol CategoryUseCase: Sendable {
    func getCategories(homeId: Int) async throws -> CategoriesResponse
    func createCategory(homeId: Int, category: Category) async throws -> GenericResponse
    func editCategory(homeId: Int, category: Category) async throws -> GenericResponse
    func deleteCategory(homeId: Int, category: Category) async throws -> GenericResponse
    func createValid(isNameValid: Bool, isDescriptionValid: Bool) -> Bool
}

final class CategoryUseCaseImpl: CategoryUseCase {
    let service: CategoryService

    init(service: CategoryService) {
        self.service = service
    }

    func getCategories(homeId: Int) async throws -> CategoriesResponse {
        try await service.getCategories(homeId: homeId)
    }

    nonisolated func createValid(isNameValid: Bool, isDescriptionValid: Bool) -> Bool {
        isNameValid && isDescriptionValid
    }

    func createCategory(homeId: Int, category: Category) async throws -> GenericResponse {
        try await service.createCategory(homeId: homeId, category: category)
    }

    func editCategory(homeId: Int, category: Category) async throws -> GenericResponse {
        try await service.editCategory(homeId: homeId, category: category)
    }

    func deleteCategory(homeId: Int, category: Category) async throws -> GenericResponse {
        try await service.deleteCategory(homeId: homeId, category: category)
    }
}
