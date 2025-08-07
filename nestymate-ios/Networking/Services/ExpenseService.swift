//
//  ExpenseService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Combine
import Foundation

protocol ExpenseService: Sendable {
    func getExpenses(homeId: Int) async throws -> ExpensesResponse
    func getExpense(homeId: Int, expenseId: Int) async throws -> ExpenseResponse
    func createExpense(homeId: Int, expense: Expense) async throws -> GenericResponse
    func editExpense(homeId: Int, expense: Expense) async throws -> GenericResponse
    func deleteExpense(homeId: Int, expense: Expense) async throws -> GenericResponse
}

final class ExpenseServiceImpl: ExpenseService {
    let baseUrl: URL
    let apiCall: APICalls

    init() {
        baseUrl = URL(string: "http://192.168.1.10/api/v1/home")!
        apiCall = APICalls()
    }

    func getExpenses(homeId: Int) async throws -> ExpensesResponse {
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expense")
        let apiResponse = try await apiCall.get(url: url, requestData: nil)
        do {
            guard let data = apiResponse.data
            else { return ExpensesResponse(
                expenses: nil,
                error: .badServerResponse,
                statusCode: apiResponse.statusCode
            ) }
            let response = try JSONDecoder().decode([Expense].self, from: data)
            return ExpensesResponse(
                expenses: response,
                error: apiResponse.error,
                statusCode: apiResponse.statusCode
            )
        } catch {
            return ExpensesResponse(expenses: nil, error: .badServerResponse, statusCode: apiResponse.statusCode)
        }
    }

    func getExpense(homeId: Int, expenseId: Int) async throws -> ExpenseResponse {
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expense")
            .appending(path: "\(expenseId)")
        let apiResponse = try await apiCall.get(url: url, requestData: nil)
        do {
            guard let data = apiResponse.data
            else { return ExpenseResponse(expense: nil, error: .badServerResponse, statusCode: apiResponse.statusCode) }
            let response = try JSONDecoder().decode(Expense.self, from: data)
            return ExpenseResponse(expense: response, error: apiResponse.error, statusCode: apiResponse.statusCode)
        } catch {
            return ExpenseResponse(expense: nil, error: .badServerResponse, statusCode: apiResponse.statusCode)
        }
    }

    func createExpense(homeId: Int, expense: Expense) async throws -> GenericResponse {
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expense")
        let data = try? JSONEncoder().encode(expense)
        let apiResponse = try await apiCall.post(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func editExpense(homeId: Int, expense: Expense) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(expense)
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expense")
            .appending(path: "\(expense.id)")
        let apiResponse = try await apiCall.put(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func deleteExpense(homeId: Int, expense: Expense) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(expense)
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expense")
            .appending(path: "\(expense.id)")
        let apiResponse = try await apiCall.delete(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }
}
