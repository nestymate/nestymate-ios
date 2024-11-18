//
//  CategoryUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

protocol CategoryUseCase {
    func getCategories(completionHandler: @escaping ([Category]?, Error?, Int?) -> Void)
    func createCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void)
    func editCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void)
    func deleteCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void)
    func createValid(isNameValid: Bool, isDescriptionValid: Bool) -> Bool
}

class CategoryUseCaseImpl: CategoryUseCase {
    let service: CategoryService?

    init(service: CategoryService?) {
        self.service = service
    }

    func getCategories(completionHandler: @escaping ([Category]?, Error?, Int?) -> Void) {
        service?.getCategories(completionHandler: completionHandler)
    }

    func createValid(isNameValid: Bool, isDescriptionValid: Bool) -> Bool {
        isNameValid && isDescriptionValid
    }

    func createCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        service?.createCategory(category: category, completionHandler: completionHandler)
    }

    func editCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        service?.editCategory(category: category, completionHandler: completionHandler)
    }

    func deleteCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        service?.deleteCategory(category: category, completionHandler: completionHandler)
    }
}
