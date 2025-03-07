//
//  CategoriesTests.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 7/3/25.
//

@testable import nestymate_ios
import Testing

class CategoriesTests {
    private var useCase: CategoryUseCase {
        CategoryUseCaseImpl(service: CategoryServiceMock())
    }

    private var useCaseFailed: CategoryUseCase {
        CategoryUseCaseImpl(service: CategoryServiceFailedMock())
    }

    @Test func createValid() {
        #expect(useCase.createValid(isNameValid: true, isDescriptionValid: true))
    }

    @Test func successfulGetCategories() {
        useCase.getCategories { _, error, _ in
            #expect(error == nil)
        }
    }

    @Test func unsuccessfulGetCategories() {
        useCaseFailed.getCategories { _, error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulEditCategory() {
        useCase.editCategory(category: CategoryTestData.category) { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulEditCategory() {
        useCaseFailed.editCategory(category: CategoryTestData.category) { error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulCreateCategory() {
        useCase.createCategory(category: CategoryTestData.category) { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulCreateCategory() {
        useCaseFailed.createCategory(category: CategoryTestData.category) { error, _ in
            #expect(error != nil)
        }
    }

    @Test func successfulDeleteCategory() {
        useCase.deleteCategory(category: CategoryTestData.category) { error, _ in
            #expect(error == nil)
        }
    }

    @Test func unSuccessfulDeleteCategory() {
        useCaseFailed.deleteCategory(category: CategoryTestData.category) { error, _ in
            #expect(error != nil)
        }
    }
}
