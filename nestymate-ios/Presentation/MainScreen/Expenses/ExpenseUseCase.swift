//
//  ExpenseUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

protocol ExpenseUseCase {
    func getExpenses(completionHandler: @escaping ([Expense]?, Error?, Int?) -> Void)
    func getExpense(expenseId: Int, completionHandler: @escaping (Expense?, Error?, Int?) -> Void)
    func createExpense(expenseCategoryId: Int, expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
    func editExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
    func deleteExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
    func createValid(
        isTitleValid: Bool,
        isDescriptionValid: Bool,
        isAmountValid: Bool,
        hasSelectedCategory: Bool
    ) -> Bool
}

class ExpenseUseCaseImpl: ExpenseUseCase {
    let service: ExpenseService?

    init(service: ExpenseService?) {
        self.service = service
    }

    func getExpenses(completionHandler: @escaping ([Expense]?, Error?, Int?) -> Void) {
        service?.getExpenses(completionHandler: completionHandler)
    }

    func getExpense(expenseId: Int, completionHandler: @escaping (Expense?, Error?, Int?) -> Void) {
        service?.getExpense(expenseId: expenseId, completionHandler: completionHandler)
    }

    func createValid(
        isTitleValid: Bool,
        isDescriptionValid: Bool,
        isAmountValid: Bool,
        hasSelectedCategory: Bool
    ) -> Bool {
        isTitleValid && isDescriptionValid && isAmountValid && hasSelectedCategory
    }

    func createExpense(expenseCategoryId: Int, expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        service?.createExpense(
            expenseCategoryId: expenseCategoryId,
            expense: expense,
            completionHandler: completionHandler
        )
    }

    func editExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        service?.editExpense(expense: expense, completionHandler: completionHandler)
    }

    func deleteExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        service?.deleteExpense(expense: expense, completionHandler: completionHandler)
    }
}
