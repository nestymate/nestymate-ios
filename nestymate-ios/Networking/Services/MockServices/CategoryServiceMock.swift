//
//  CategoryServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 7/3/25.
//

final class CategoryServiceMock: CategoryService {
    let category = Category(id: 123, name: "test category", description: "")

    func getCategories(homeId _: Int) async throws -> CategoriesResponse {
        CategoriesResponse(categories: [category], statusCode: 200, shouldLogout: false)
    }

    func getCategory(categoryId _: Int) async throws -> CategoryResponse {
        CategoryResponse(category: category, statusCode: 200, shouldLogout: false)
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
