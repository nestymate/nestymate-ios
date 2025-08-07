//
//  CategoryServiceFailedMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 7/3/25.
//

final class CategoryServiceFailedMock: CategoryService {
    func getCategories(homeId _: Int) async throws -> CategoriesResponse {
        CategoriesResponse(categories: nil, statusCode: 500, shouldLogout: false)
    }

    func createCategory(homeId _: Int, category _: Category) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func editCategory(homeId _: Int, category _: Category) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func deleteCategory(homeId _: Int, category _: Category) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }
}
