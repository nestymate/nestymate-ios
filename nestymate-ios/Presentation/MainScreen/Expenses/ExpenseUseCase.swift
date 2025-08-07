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
    func createExpense(homeId: Int, expense: Expense) async throws -> GenericResponse
    func editExpense(homeId: Int, expense: Expense) async throws -> GenericResponse
    func deleteExpense(homeId: Int, expense: Expense) async throws -> GenericResponse
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

    func editExpense(homeId: Int, expense: Expense) async throws -> GenericResponse {
        try await service.editExpense(homeId: homeId, expense: expense)
    }

    func deleteExpense(homeId: Int, expense: Expense) async throws -> GenericResponse {
        try await service.deleteExpense(homeId: homeId, expense: expense)
    }
}
