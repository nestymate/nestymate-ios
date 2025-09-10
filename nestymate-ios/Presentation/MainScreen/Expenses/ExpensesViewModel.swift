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
    public func getExpenses() async throws -> [Expense]? {
        shouldShowLoader = true
        do {
            let responseHome = try await homeUseCase.getActiveHome()
            let apiResponse = try await useCase.getExpenses(homeId: responseHome.home?.id ?? -1)
            shouldShowLoader = false
            return apiResponse.expenses
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return nil
    }

    @MainActor
    public func delete(expenseToBeDelete: Expense) async throws -> [Expense]? {
        shouldShowLoader = true
        do {
            _ = try await useCase.deleteExpense(expense: expenseToBeDelete)
            shouldShowLoader = false
            return try await getExpenses()
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return nil
    }
}
