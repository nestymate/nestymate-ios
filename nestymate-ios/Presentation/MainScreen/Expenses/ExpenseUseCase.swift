//
//  ExpenseUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

protocol ExpenseUseCase {
    func getExpenses(completionHandler: @escaping ([Expense]?, Error?, Int?) -> Void)
    func createExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
    func editExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
    func deleteExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
    func createValid(isTitleValid: Bool, isDescriptionValid: Bool, isAmountValid: Bool) -> Bool
}

class ExpenseUseCaseImpl: ExpenseUseCase {
    let service: ExpenseService = ExpenseServiceImpl()

    func getExpenses(completionHandler: @escaping ([Expense]?, Error?, Int?) -> Void) {
        service.getExpenses(completionHandler: completionHandler)
    }

    func createValid(isTitleValid: Bool, isDescriptionValid: Bool, isAmountValid: Bool) -> Bool {
        return isTitleValid && isDescriptionValid && isAmountValid
    }

    func createExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        service.createExpense(expense: expense, completionHandler: completionHandler)
    }

    func editExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        service.editExpense(expense: expense, completionHandler: completionHandler)
    }

    func deleteExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        service.deleteExpense(expense: expense, completionHandler: completionHandler)
    }
}
