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

    init(useCase: ExpenseUseCase, logoutService: LogoutService) {
        self.useCase = useCase
        self.logoutService = logoutService
    }

    public func getExpenses(completionHandler: @escaping ([Expense]?, Bool) -> Void) {
        shouldShowLoader = true
        useCase.getExpenses { [weak self] expenses, error, statusCode in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            completionHandler(expenses, logoutService.shouldLogout(statusCode: statusCode))
        }
    }

    public func delete(expenseToBeDelete: Expense, completionHandler: @escaping ([Expense]?, Bool) -> Void) {
        shouldShowLoader = true
        useCase.deleteExpense(expense: expenseToBeDelete) { [weak self] error, _ in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            getExpenses(completionHandler: completionHandler)
        }
    }
}
