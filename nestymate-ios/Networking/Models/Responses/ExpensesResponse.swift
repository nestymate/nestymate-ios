//
//  ExpensesResponse.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/7/25.
//

struct ExpensesResponse: Sendable {
    let expenses: [Expense]?
    let error: HttpError?
    let statusCode: Int?
}

struct ExpenseResponse: Sendable {
    let expense: Expense?
    let error: HttpError?
    let statusCode: Int?
}
