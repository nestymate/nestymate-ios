//
//  ExpensesServiceFailedMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/3/25.
//

final class ExpensesServiceFailedMock: ExpenseService {
    func getExpenses() async throws -> ExpensesResponse {
        ExpensesResponse(expenses: nil, error: .badServerResponse, statusCode: 500)
    }

    func getExpense(expenseId _: Int) async throws -> ExpenseResponse {
        ExpenseResponse(expense: nil, error: .badServerResponse, statusCode: 500)
    }

    func createExpense(expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func editExpense(expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func deleteExpense(expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }
}
