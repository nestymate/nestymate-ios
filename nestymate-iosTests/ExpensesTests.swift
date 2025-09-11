//
//  ExpensesTests.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/3/25.
//

@testable import nestymate_ios
import Testing

class ExpensesTests {
    private let homeId = HomeTestsData.home.id

    private var useCase: ExpenseUseCase {
        ExpenseUseCaseImpl(service: ExpensesServiceMock())
    }

    private var useCaseFailed: ExpenseUseCase {
        ExpenseUseCaseImpl(service: ExpensesServiceFailedMock())
    }

    @Test func checkValid() {
        #expect(useCase.createValid(isTitleValid: true, isDescriptionValid: true, isAmountValid: true).success)
    }

    @Test func checkInValid() {
        #expect(useCase.createValid(
            isTitleValid: false,
            isDescriptionValid: true,
            isAmountValid: true
        ).error == .fillAllValues)
    }

    @Test func successfulGetExpenses() async {
        let response = try? await useCase.getExpenses(homeId: homeId)
        #expect(response?.error == nil)
    }

    @Test func unsuccessfulGetExpenses() async {
        let response = try? await useCaseFailed.getExpenses(homeId: homeId)
        #expect(response?.error != nil)
    }

    @Test func successfulGetExpense() async {
        let response = try? await useCase.getExpense(homeId: homeId, expenseId: 0)
        #expect(response?.error == nil)
    }

    @Test func unsuccessfulGetExpense() async {
        let response = try? await useCaseFailed.getExpense(homeId: homeId, expenseId: 0)
        #expect(response?.error != nil)
    }

    @Test func successfulEditExpense() async {
        let response = try? await useCase.editExpense(expense: ExpenseTestData.expense)
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulEditExpense() async {
        let response = try? await useCaseFailed.editExpense(expense: ExpenseTestData.expense)
        #expect(response?.error != nil)
    }

    @Test func successfulGetUserForExpense() async {
        let response = try? await useCase.getUserForHome(homeId: homeId)
        #expect(response?.error == nil)
    }

    @Test func unsuccessfulGetUserForExpense() async {
        let response = try? await useCaseFailed.getUserForHome(homeId: homeId)
        #expect(response?.error != nil)
    }

    @Test func successfulCreateExpense() async {
        let response = try? await useCase.createExpense(homeId: homeId, expense: ExpenseTestData.expense)
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulCreateExpense() async {
        let response = try? await useCaseFailed.createExpense(homeId: homeId, expense: ExpenseTestData.expense)
        #expect(response?.error != nil)
    }

    @Test func successfulDeleteExpense() async {
        let response = try? await useCase.deleteExpense(expense: ExpenseTestData.expense)
        #expect(response?.error == nil)
    }

    @Test func unSuccessfulDeleteExpense() async {
        let response = try? await useCaseFailed.deleteExpense(expense: ExpenseTestData.expense)
        #expect(response?.error != nil)
    }
}
