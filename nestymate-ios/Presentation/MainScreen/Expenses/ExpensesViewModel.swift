//
//  ExpensesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

class ExpensesViewModel: ObservableObject {
    private let useCase: ExpenseUseCase
    private let logoutService: LogoutService
    @Published var shouldShowLoader: Bool?
    @Published var error: Error?
    @Published var expenses: [Expense] = []

    init(useCase: ExpenseUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    public func getExpenses(completionHandler: @escaping (Bool) -> Void) {
        shouldShowLoader = true
        useCase.getExpenses { [weak self] expenses, error, statusCode in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            self.expenses = expenses ?? []
            completionHandler(logoutService.shouldLogout(statusCode: statusCode))
        }
    }

    public func delete(at offset: IndexSet, completionHandler: @escaping (Bool) -> Void) {
        let index = offset[offset.startIndex]
        shouldShowLoader = true
        let expenseToBeDelete = expenses[index]
        useCase.deleteExpense(expense: expenseToBeDelete) { [weak self] error, _ in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            getExpenses(completionHandler: completionHandler)
        }
    }
}
