//
//  CategoryUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

protocol CategoryUseCase: Sendable {
    func getCategories() async throws -> CategoriesResponse
    func createCategory(category: Category) async throws -> GenericResponse
    func editCategory(category: Category) async throws -> GenericResponse
    func deleteCategory(category: Category) async throws -> GenericResponse
    func createValid(isNameValid: Bool, isDescriptionValid: Bool) -> Bool
}

final class CategoryUseCaseImpl: CategoryUseCase {
    let service: CategoryService

    init(service: CategoryService) {
        self.service = service
    }

    func getCategories() async throws -> CategoriesResponse {
        try await service.getCategories()
    }

    nonisolated func createValid(isNameValid: Bool, isDescriptionValid: Bool) -> Bool {
        isNameValid && isDescriptionValid
    }

    func createCategory(category: Category) async throws -> GenericResponse {
        try await service.createCategory(category: category)
    }

    func editCategory(category: Category) async throws -> GenericResponse {
        try await service.editCategory(category: category)
    }

    func deleteCategory(category: Category) async throws -> GenericResponse {
        try await service.deleteCategory(category: category)
    }
}
