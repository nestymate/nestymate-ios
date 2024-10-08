//
//  CategoryService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 12/10/24.
//

import Combine
import Foundation

protocol CategoryService {
    func getCategories(completionHandler: @escaping ([Category]?, Error?, Int?) -> Void)
    func createCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void)
    func editCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void)
    func deleteCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void)
}

class CategoryServiceImpl: CategoryService {
    var baseUrl: URL
    var cancellable = Set<AnyCancellable>()
    let helper = KeychainHelper()
    var apiCall = APICalls()
    var homeUserDefaults = HomeUserDefaults()

    public init() {
        baseUrl = URL(string: "http://192.168.1.10/api/v1/home")!
            .appendingPathComponent(homeUserDefaults.getHomeId())
            .appendingPathComponent("expensecategory")
    }

    func getCategories(completionHandler: @escaping ([Category]?, Error?, Int?) -> Void) {
        apiCall.get(url: baseUrl, requestData: nil) { apiResponse in
            do {
                guard let data = apiResponse.data
                else { return completionHandler(nil, .badServerResponse, apiResponse.statusCode) }
                let response = try JSONDecoder().decode([Category].self, from: data)
                return completionHandler(response, apiResponse.error, apiResponse.statusCode)
            } catch {
                return completionHandler(nil, .badServerResponse, apiResponse.statusCode)
            }
        }
    }

    func createCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(category)
        apiCall.post(url: baseUrl, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }

    func editCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(category)
        let putURL = baseUrl.appending(path: "\(category.id)")
        apiCall.put(url: putURL, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }

    func deleteCategory(category: Category, completionHandler: @escaping (Error?, Int?) -> Void) {
        let data = try? JSONEncoder().encode(category)
        let putURL = baseUrl.appending(path: "\(category.id)")
        apiCall.delete(url: putURL, requestData: data) { apiResponse in
            completionHandler(apiResponse.error, apiResponse.statusCode)
        }
    }
}
