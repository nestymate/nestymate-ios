//
//  CategoryService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 12/10/24.
//

import Combine
import Foundation

protocol CategoryService: Sendable {
    func getCategories(homeId: Int) async throws -> CategoriesResponse
    func createCategory(homeId: Int, category: Category) async throws -> GenericResponse
    func editCategory(homeId: Int, category: Category) async throws -> GenericResponse
    func deleteCategory(homeId: Int, category: Category) async throws -> GenericResponse
}

final class CategoryServiceImpl: CategoryService {
    let baseUrl: URL
    let apiCall: APICalls

    public init() {
        baseUrl = URL(string: "http://192.168.1.10/api/v1/home")!
        apiCall = APICalls()
    }

    func getCategories(homeId: Int) async throws -> CategoriesResponse {
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expensecategory")
        let apiResponse = try await apiCall.get(url: url, requestData: nil)

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

    func createCategory(homeId: Int, category: Category) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(category)
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expensecategory")
        let apiResponse = try await apiCall.post(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func editCategory(homeId: Int, category: Category) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(category)
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expensecategory")
            .appending(path: "\(category.id)")
        let apiResponse = try await apiCall.put(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func deleteCategory(homeId: Int, category: Category) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(category)
        let url = baseUrl.appendingPathComponent(String(homeId))
            .appendingPathComponent("expensecategory")
            .appending(path: "\(category.id)")
        let apiResponse = try await apiCall.delete(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }
}
