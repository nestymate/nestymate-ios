//
//  CategoryServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 7/3/25.
//

final class CategoryServiceMock: CategoryService {
    func getCategories(homeId _: Int) async throws -> CategoriesResponse {
        let categories = [Category(id: 123, code: "", name: "test category", description: "")]
        return CategoriesResponse(categories: categories, statusCode: 200, shouldLogout: false)
    }

    func createCategory(homeId _: Int, category _: Category) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func editCategory(homeId _: Int, category _: Category) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func deleteCategory(homeId _: Int, category _: Category) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }
}
