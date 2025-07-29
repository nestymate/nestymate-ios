//
//  CategoryServiceFailedMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 7/3/25.
//

final class CategoryServiceFailedMock: CategoryService {
    func getCategories() async throws -> CategoriesResponse {
        CategoriesResponse(categories: nil, statusCode: 500, shouldLogout: false)
    }

    func createCategory(category _: Category) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func editCategory(category _: Category) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func deleteCategory(category _: Category) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }
}
