//
//  ExpensesResponse.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/7/25.
//

struct ExpensesResponse: Sendable {
    let expenses: [Expense]?
    let error: Error?
    let statusCode: Int?
    let shouldLogout: Bool

    init(expenses: [Expense]?, error: Error?, statusCode: Int?, shouldLogout: Bool = false) {
        self.expenses = expenses
        self.error = error
        self.statusCode = statusCode
        self.shouldLogout = shouldLogout
    }
}

struct ExpenseResponse: Sendable {
    let expense: Expense?
    let error: Error?
    let statusCode: Int?
    let shouldLogout: Bool

    init(expense: Expense?, error: Error?, statusCode: Int?, shouldLogout: Bool = false) {
        self.expense = expense
        self.error = error
        self.statusCode = statusCode
        self.shouldLogout = shouldLogout
    }
}
