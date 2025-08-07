//
//  ExpensesServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/3/25.
//

final class ExpensesServiceMock: ExpenseService {
    private let expense = Expense(id: 0, title: "test", description: "", amount: 12, categoryId: 0)
    func getExpenses(homeId _: Int) async throws -> ExpensesResponse {
        ExpensesResponse(expenses: [expense], error: nil, statusCode: 200)
    }

    func getExpense(homeId _: Int, expenseId _: Int) async throws -> ExpenseResponse {
        ExpenseResponse(expense: expense, error: nil, statusCode: 200)
    }

    func createExpense(homeId _: Int, expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func editExpense(homeId _: Int, expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func deleteExpense(homeId _: Int, expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }
}
