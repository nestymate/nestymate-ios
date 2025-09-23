//
//  ExpensesServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/3/25.
//

final class ExpensesServiceMock: ExpenseService {
    private let expense = Expense(
        id: 11,
        title: "erw", amount: 12,
        date: "2025-09-09T14:45:52.703Z",
        description: "",
        expenseCategoryId: 0,
        participatingUserIds: [1]
    )
    func getExpenses(homeId _: Int) async throws -> ExpensesResponse {
        ExpensesResponse(expenses: [expense], error: nil, statusCode: 200)
    }

    func getExpense(homeId _: Int, expenseId _: Int) async throws -> ExpenseResponse {
        ExpenseResponse(expense: expense, error: nil, statusCode: 200)
    }

    func getUserForExpenses(homeId _: Int) async throws -> UserResponse {
        UserResponse(users: [UserExpense(id: 0, username: "test")], error: nil, statusCode: 200)
    }

    func createExpense(homeId _: Int, expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func editExpense(expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func deleteExpense(expense _: Expense) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }
}
