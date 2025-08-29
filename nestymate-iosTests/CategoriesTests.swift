//
//  CategoriesTests.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 7/3/25.
//

@testable import nestymate_ios
import Testing

class CategoriesTests {
    private let homeId = HomeTestsData.home.id
    private var useCase: CategoryUseCase {
        CategoryUseCaseImpl(service: CategoryServiceMock())
    }

    private var useCaseFailed: CategoryUseCase {
        CategoryUseCaseImpl(service: CategoryServiceFailedMock())
    }

    @Test func createValid() {
        #expect(useCase.createValid(isNameValid: true, isDescriptionValid: true))
    }

    @Test func successfulGetCategories() async {
        let response = try? await useCase.getCategories(homeId: homeId)
        #expect(response?.categories != nil)
    }

    @Test func unsuccessfulGetCategories() async {
        let response = try? await useCaseFailed.getCategories(homeId: homeId)
        #expect(response?.categories == nil)
    }

    @Test func successfulGetCategory() async {
        let response = try? await useCase.getCategory(categoryId: 1)
        #expect(response?.category != nil)
    }

    @Test func unsuccessfulGetCategory() async {
        let response = try? await useCaseFailed.getCategory(categoryId: 1)
        #expect(response?.category == nil)
    }

    @Test func successfulEditCategory() async {
        let response = try? await useCase.editCategory(homeId: homeId, category: CategoryTestData.category)
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulEditCategory() async {
        let response = try? await useCaseFailed.editCategory(homeId: homeId, category: CategoryTestData.category)
        #expect(response?.error != nil)
    }

    @Test func successfulCreateCategory() async {
        let response = try? await useCase.createCategory(homeId: homeId, category: CategoryTestData.category)
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulCreateCategory() async {
        let response = try? await useCaseFailed.createCategory(homeId: homeId, category: CategoryTestData.category)
        #expect(response?.error != nil)
    }

    @Test func successfulDeleteCategory() async {
        let response = try? await useCase.deleteCategory(homeId: homeId, category: CategoryTestData.category)
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulDeleteCategory() async {
        let response = try? await useCaseFailed.deleteCategory(homeId: homeId, category: CategoryTestData.category)
        #expect(response?.error != nil)
    }
}
