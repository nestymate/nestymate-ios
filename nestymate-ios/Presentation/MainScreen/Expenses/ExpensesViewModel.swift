//
//  ExpensesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

final class ExpensesViewModel: ObservableObject {
    private let useCase: ExpenseUseCase
    private let logoutService: LogoutService
    @Published var shouldShowLoader: Bool?
    @Published var error: HttpError?

    init(useCase: ExpenseUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    @MainActor
    public func getExpenses() async throws -> ExpensesResponse {
        shouldShowLoader = true
        let apiResponse = try? await useCase.getExpenses()
        shouldShowLoader = false
        return ExpensesResponse(
            expenses: apiResponse?.expenses,
            error: apiResponse?.error,
            statusCode: apiResponse?.statusCode,
            shouldLogout: logoutService.shouldLogout(statusCode: apiResponse?.statusCode)
        )
    }

    @MainActor
    public func delete(expenseToBeDelete: Expense) async throws -> ExpensesResponse {
        shouldShowLoader = true
        let response = try? await useCase.deleteExpense(expense: expenseToBeDelete)
        shouldShowLoader = false
        error = response?.error
        return try await getExpenses()
    }
}
