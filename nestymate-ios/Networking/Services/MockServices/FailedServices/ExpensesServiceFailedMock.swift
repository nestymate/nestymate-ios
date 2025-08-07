//
//  ExpensesServiceFailedMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/3/25.
//

final class ExpensesServiceFailedMock: ExpenseService {
    func getExpenses(homeId _: Int) async throws -> ExpensesResponse {
        ExpensesResponse(expenses: nil, error: .badServerResponse, statusCode: 500)
    }

    func getExpense(homeId _: Int, expenseId _: Int) async throws -> ExpenseResponse {
        ExpenseResponse(expense: nil, error: .badServerResponse, statusCode: 500)
    }

    func createExpense(homeId _: Int, expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func editExpense(homeId _: Int, expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func deleteExpense(homeId _: Int, expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }
}
