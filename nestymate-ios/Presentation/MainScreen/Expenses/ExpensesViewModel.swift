//
//  ExpensesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

class ExpensesViewModel: ObservableObject {
    let useCase: ExpenseUseCase = ExpenseUseCaseImpl()
    @Published public var shouldShowLoader: Bool?
    @Published var error: Error?
    private var expenses: [Expense]?
    private let logoutService = LogoutService()

    public func getExpenses(completionHandler: @escaping ([Expense]?, Bool) -> Void) {
        shouldShowLoader = true
        useCase.getExpenses { [weak self] expenses, error, statusCode in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            self.expenses = expenses
            completionHandler(expenses, logoutService.shouldLogout(statusCode: statusCode))
        }
    }

    public func delete(at offset: IndexSet) {
        let index = offset[offset.startIndex]
        shouldShowLoader = true
        guard let expenseToBeDelete = expenses?[index] else { return }
        useCase.deleteExpense(expense: expenseToBeDelete) { [weak self] error, _ in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            expenses?.remove(atOffsets: offset)
        }
    }
}
