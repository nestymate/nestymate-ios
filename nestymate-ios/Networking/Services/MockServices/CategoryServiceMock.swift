//
//  CategoryServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 7/3/25.
//

final class CategoryServiceMock: CategoryService {
    func getCategories(completionHandler: @escaping ([Category]?, Error?, Int?) -> Void) {
        let categories = [Category(id: 123, code: "", name: "test category", description: "")]
        completionHandler(categories, nil, 200)
    }

    func createCategory(category _: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }

    func editCategory(category _: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }

    func deleteCategory(category _: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }
}
