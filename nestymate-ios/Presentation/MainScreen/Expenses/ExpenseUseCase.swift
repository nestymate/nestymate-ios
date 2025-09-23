//
//  ExpenseUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

protocol ExpenseUseCase: Sendable {
    func getExpenses(homeId: Int) async throws -> ExpensesResponse
    func getExpense(homeId: Int, expenseId: Int) async throws -> ExpenseResponse
    func getUserForHome(homeId: Int) async throws -> UserResponse
    func createExpense(homeId: Int, expense: Expense) async throws -> GenericResponse
    func editExpense(expense: Expense) async throws -> GenericResponse
    func deleteExpense(expense: Expense) async throws -> GenericResponse
    func createValid(
        isTitleValid: Bool,
        isDescriptionValid: Bool,
        isAmountValid: Bool
    ) -> SuccessResponse
}

final class ExpenseUseCaseImpl: ExpenseUseCase {
    let service: ExpenseService

    init(service: ExpenseService) {
        self.service = service
    }

    func getExpenses(homeId: Int) async throws -> ExpensesResponse {
        try await service.getExpenses(homeId: homeId)
    }

    func getExpense(homeId: Int, expenseId: Int) async throws -> ExpenseResponse {
        try await service.getExpense(homeId: homeId, expenseId: expenseId)
    }

    func getUserForHome(homeId: Int) async throws -> UserResponse {
        try await service.getUserForExpenses(homeId: homeId)
    }

    nonisolated func createValid(
        isTitleValid: Bool,
        isDescriptionValid: Bool,
        isAmountValid: Bool
    ) -> SuccessResponse {
        if !isTitleValid || !isDescriptionValid || !isAmountValid {
            return SuccessResponse(success: false, error: .fillAllValues)
        }
        return SuccessResponse(success: true, error: nil)
    }

    func createExpense(homeId: Int, expense: Expense) async throws -> GenericResponse {
        try await service.createExpense(homeId: homeId, expense: expense)
    }

    func editExpense(expense: Expense) async throws -> GenericResponse {
        try await service.editExpense(expense: expense)
    }

    func deleteExpense(expense: Expense) async throws -> GenericResponse {
        try await service.deleteExpense(expense: expense)
    }
}
