//
//  ExpensesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

final class ExpensesViewModel: ObservableObject {
    private let useCase: ExpenseUseCase
    private let homeUseCase: HomeUseCase
    private let logoutService: LogoutService
    @Published var shouldShowLoader: Bool?
    @Published var error: HttpError?

    init(useCase: ExpenseUseCase, homeUseCase: HomeUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.homeUseCase = homeUseCase
        self.logoutService = logoutService
    }

    @MainActor
    public func getExpenses() async throws -> ExpensesResponse {
        shouldShowLoader = true
        let responseHome = try await homeUseCase.getActiveHome()
        let apiResponse = try? await useCase.getExpenses(homeId: responseHome.home?.id ?? -1)
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
        let responseHome = try await homeUseCase.getActiveHome()
        let response = try? await useCase.deleteExpense(homeId: responseHome.home?.id ?? -1, expense: expenseToBeDelete)
        shouldShowLoader = false
        error = response?.error
        return try await getExpenses()
    }
}
