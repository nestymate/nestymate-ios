//
//  ExpensesServiceFailedMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/3/25.
//

final class ExpensesServiceFailedMock: ExpenseService {
    func getExpenses(completionHandler: @escaping ([Expense]?, Error?, Int?) -> Void) {
        completionHandler(nil, .badServerResponse, 500)
    }

    func getExpense(expenseId _: Int, completionHandler: @escaping (Expense?, Error?, Int?) -> Void) {
        completionHandler(nil, .badServerResponse, 500)
    }

    func createExpense(expense _: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(.badServerResponse, 500)
    }

    func editExpense(expense _: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(.badServerResponse, 500)
    }

    func deleteExpense(expense _: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(.badServerResponse, 500)
    }
}
