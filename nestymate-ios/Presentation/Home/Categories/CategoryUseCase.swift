//
//  CategoryUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

protocol CategoryUseCase {
    func getCategory(completionHandler: @escaping ([Category], Error?) -> Void)
    func createCategory(completionHandler: @escaping (Error?) -> Void)
}

class CategoryUseCaseImpl: CategoryUseCase {
    func getCategory(completionHandler: @escaping ([Category], Error?) -> Void) {
        let categories = [Category(name: "Category 1"), Category(name: "Category 2"), Category(name: "Category 3")]
        completionHandler(categories, nil)
    }

    func createCategory(completionHandler _: @escaping (Error?) -> Void) {}
}
