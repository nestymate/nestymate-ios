//
//  CategoryServiceFailedMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 7/3/25.
//

final class CategoryServiceFailedMock: CategoryService {
    func getCategories(completionHandler: @escaping ([Category]?, Error?, Int?) -> Void) {
        completionHandler(nil, .badServerResponse, 500)
    }

    func createCategory(category _: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(.badServerResponse, 500)
    }

    func editCategory(category _: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(.badServerResponse, 500)
    }

    func deleteCategory(category _: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(.badServerResponse, 500)
    }
}
