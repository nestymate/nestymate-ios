//
//  ExpensesServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/3/25.
//

final class ExpensesServiceMock: ExpenseService {
    private let expense = Expense(id: 0, title: "test", description: "", amount: 12, categoryId: 0)
    func getExpenses(completionHandler: @escaping ([Expense]?, Error?, Int?) -> Void) {
        completionHandler([expense], nil, 200)
    }

    func getExpense(expenseId _: Int, completionHandler: @escaping (Expense?, Error?, Int?) -> Void) {
        completionHandler(expense, nil, 200)
    }

    func createExpense(expense _: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }

    func editExpense(expense _: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }

    func deleteExpense(expense _: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }
}
