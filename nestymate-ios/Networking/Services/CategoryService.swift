//
//  CategoryService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 12/10/24.
//

import Combine
import Foundation

protocol CategoryService: Sendable {
    func getCategories() async throws -> CategoriesResponse
    func createCategory(category: Category) async throws -> GenericResponse
    func editCategory(category: Category) async throws -> GenericResponse
    func deleteCategory(category: Category) async throws -> GenericResponse
}

final class CategoryServiceImpl: CategoryService {
    let baseUrl: URL
    let helper: KeychainHelper
    let apiCall: APICalls
    let homeUserDefaults: HomeUserDefaults

    public init() {
        homeUserDefaults = HomeUserDefaults()
        baseUrl = URL(string: "http://192.168.1.10/api/v1/home")!
            .appendingPathComponent(homeUserDefaults.getHomeId())
            .appendingPathComponent("expensecategory")
        apiCall = APICalls()
        helper = KeychainHelper()
    }

    func getCategories() async throws -> CategoriesResponse {
        let apiResponse = try await apiCall.get(url: baseUrl, requestData: nil)

        guard let data = apiResponse.data else {
            throw URLError(.badServerResponse)
        }

        do {
            let categories = try JSONDecoder().decode([Category].self, from: data)
            return CategoriesResponse(
                categories: categories,
                statusCode: apiResponse.statusCode,
                shouldLogout: false
            )
        } catch {
            throw URLError(.cannotDecodeRawData)
        }
    }

    func createCategory(category: Category) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(category)
        let apiResponse = try await apiCall.post(url: baseUrl, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func editCategory(category: Category) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(category)
        let putURL = baseUrl.appending(path: "\(category.id)")
        let apiResponse = try await apiCall.put(url: putURL, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func deleteCategory(category: Category) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(category)
        let putURL = baseUrl.appending(path: "\(category.id)")
        let apiResponse = try await apiCall.delete(url: putURL, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }
}
