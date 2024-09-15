//
//  ExpenseService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Combine
import Foundation

protocol ExpenseService {
    func getExpenses(completionHandler: @escaping ([Expense]?, Error?) -> Void)
    func createExpense(expense: Expense, completionHandler: @escaping (Error?) -> Void)
    func editExpense(expense: Expense, completionHandler: @escaping (Error?) -> Void)
    func deleteExpense(expense: Expense, completionHandler: @escaping (Error?) -> Void)
}

class ExpenseServiceImpl: ExpenseService {
    let url = URL(string: "http://192.168.1.10/api/v1/expense")!
    var cancellable = Set<AnyCancellable>()
    let helper = KeychainHelper()
    var apiCall = APICalls()

    func getExpenses(completionHandler: @escaping ([Expense]?, Error?) -> Void) {
        apiCall.get(url: url, requestData: nil) { apiResponse in
            do {
                guard let data = apiResponse.data else { return completionHandler(nil, .badServerResponse) }
                let response = try JSONDecoder().decode([Expense].self, from: data)
                return completionHandler(response, apiResponse.error)
            } catch {
                print(error)
                return completionHandler(nil, .badServerResponse)
            }
        }
    }

    func createExpense(expense: Expense, completionHandler: @escaping (Error?) -> Void) {
        let data = try? JSONEncoder().encode(expense)
        apiCall.post(url: url, requestData: data) { apiResponse in
            completionHandler(apiResponse.error)
        }
    }

    func editExpense(expense: Expense, completionHandler: @escaping (Error?) -> Void) {
        let data = try? JSONEncoder().encode(expense)
        let putURL = url.appending(path: expense.title ?? "")
        apiCall.put(url: putURL, requestData: data) { apiResponse in
            completionHandler(apiResponse.error)
        }
    }

    func deleteExpense(expense: Expense, completionHandler: @escaping (Error?) -> Void) {
        let data = try? JSONEncoder().encode(expense)
        let putURL = url.appending(path: expense.title ?? "")
        apiCall.delete(url: putURL, requestData: data) { apiResponse in
            completionHandler(apiResponse.error)
        }
    }
}
