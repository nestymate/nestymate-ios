//
//  ExpenseService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Combine
import Foundation

protocol ExpenseService {
    func getExpenses(completionHandler: @escaping ([Expense]?, Error?, Int?) -> Void)
    func getExpense(expenseId: Int, completionHandler: @escaping (Expense?, Error?, Int?) -> Void)
    func createExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
    func editExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
    func deleteExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void)
}

class ExpenseServiceImpl: ExpenseService {
    var baseUrl: URL
    var cancellable = Set<AnyCancellable>()
    let helper = KeychainHelper()
    var apiCall = APICalls()
    var homeUserDefaults = HomeUserDefaults()

    init() {
        baseUrl = URL(string: "http://192.168.1.10/api/v1/home")!
            .appendingPathComponent(homeUserDefaults.getHomeId())
            .appendingPathComponent("expense")
    }

    func getExpenses(completionHandler: @escaping ([Expense]?, Error?, Int?) -> Void) {
        apiCall.get(url: baseUrl, requestData: nil) { apiResponse in
            do {
                guard let data = apiResponse.data
                else { return completionHandler(nil, .badServerResponse, apiResponse.statusCode) }
                let response = try JSONDecoder().decode([Expense].self, from: data)
                return completionHandler(response, apiResponse.error, apiResponse.statusCode)
            } catch {
                return completionHandler(nil, .badServerResponse, apiResponse.statusCode)
            }
        }
    }

    func getExpense(expenseId: Int, completionHandler: @escaping (Expense?, Error?, Int?) -> Void) {
        let singleGetURL = baseUrl.appending(path: "\(expenseId)")
        apiCall.get(url: singleGetURL, requestData: nil) { apiResponse in
            do {
                guard let data = apiResponse.data
                else { return completionHandler(nil, .badServerResponse, apiResponse.statusCode) }
                let response = try JSONDecoder().decode(Expense.self, from: data)
                return completionHandler(response, apiResponse.error, apiResponse.statusCode)
            } catch {
                return completionHandler(nil, .badServerResponse, apiResponse.statusCode)
            }
        }
    }

    func createExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(expense)
        apiCall.post(url: baseUrl, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }

    func editExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(expense)
        let putURL = baseUrl.appending(path: "\(expense.id)")
        apiCall.put(url: putURL, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }

    func deleteExpense(expense: Expense, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(expense)
        let putURL = baseUrl.appending(path: "\(expense.id)")
        apiCall.delete(url: putURL, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }
}
