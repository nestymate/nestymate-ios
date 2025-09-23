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
    @Published var expenses: [Expense] = []

    init(useCase: ExpenseUseCase, homeUseCase: HomeUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.homeUseCase = homeUseCase
        self.logoutService = logoutService
    }

    @MainActor
    public func getExpenses() async throws {
        shouldShowLoader = true
        do {
            let responseHome = try await homeUseCase.getActiveHome()
            let apiResponse = try await useCase.getExpenses(homeId: responseHome.home?.id ?? -1)
            shouldShowLoader = false
            expenses = apiResponse.expenses ?? []
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
    }

    @MainActor
    public func delete(at offsets: IndexSet) async throws {
        guard let index = offsets.first else { return }
        let expenseToBeDelete = expenses[index]
        expenses.remove(at: index)
        shouldShowLoader = true
        do {
            _ = try await useCase.deleteExpense(expense: expenseToBeDelete)
            shouldShowLoader = false
            try await getExpenses()
        } catch {
            expenses.insert(expenseToBeDelete, at: index)
            self.error = error as? HttpError
        }
        shouldShowLoader = false
    }
}
