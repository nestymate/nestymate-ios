//
//  ExpenseService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Combine
import Foundation

protocol ExpenseService: Sendable {
    func getExpenses() async throws -> ExpensesResponse
    func getExpense(expenseId: Int) async throws -> ExpenseResponse
    func createExpense(expense: Expense) async throws -> GenericResponse
    func editExpense(expense: Expense) async throws -> GenericResponse
    func deleteExpense(expense: Expense) async throws -> GenericResponse
}

final class ExpenseServiceImpl: ExpenseService {
    let baseUrl: URL
    let helper: KeychainHelper
    let apiCall: APICalls
    let homeUserDefaults: HomeUserDefaults

    init() {
        homeUserDefaults = HomeUserDefaults()
        baseUrl = URL(string: "http://192.168.1.10/api/v1/home")!
            .appendingPathComponent(homeUserDefaults.getHomeId())
            .appendingPathComponent("expense")
        apiCall = APICalls()
        helper = KeychainHelper()
    }

    func getExpenses() async throws -> ExpensesResponse {
        let apiResponse = try await apiCall.get(url: baseUrl, requestData: nil)
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

    func getExpense(expenseId: Int) async throws -> ExpenseResponse {
        let singleGetURL = baseUrl.appending(path: "\(expenseId)")
        let apiResponse = try await apiCall.get(url: singleGetURL, requestData: nil)
        do {
            guard let data = apiResponse.data
            else { return ExpenseResponse(expense: nil, error: .badServerResponse, statusCode: apiResponse.statusCode) }
            let response = try JSONDecoder().decode(Expense.self, from: data)
            return ExpenseResponse(expense: response, error: apiResponse.error, statusCode: apiResponse.statusCode)
        } catch {
            return ExpenseResponse(expense: nil, error: .badServerResponse, statusCode: apiResponse.statusCode)
        }
    }

    func createExpense(expense: Expense) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(expense)
        let apiResponse = try await apiCall.post(url: baseUrl, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func editExpense(expense: Expense) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(expense)
        let putURL = baseUrl.appending(path: "\(expense.id)")
        let apiResponse = try await apiCall.put(url: putURL, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func deleteExpense(expense: Expense) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(expense)
        let putURL = baseUrl.appending(path: "\(expense.id)")
        let apiResponse = try await apiCall.delete(url: putURL, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }
}
