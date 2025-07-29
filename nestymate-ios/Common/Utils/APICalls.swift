//
//  APICalls.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 17/7/24.
//

import Combine
import Foundation

final class APICalls: Sendable {
    let helper = KeychainHelper()

    func post(
        url: URL,
        requestData: Data? = nil,
        authentication: Bool = true
    ) async throws -> APIResponse {
        await genericCall(url, requestData, "POST", authentication)
    }

    func get(url: URL, requestData: Data?, authentication: Bool = true) async throws -> APIResponse {
        await genericCall(url, requestData, "GET", authentication)
    }

    func put(
        url: URL,
        requestData: Data? = nil,
        authentication: Bool = true
    ) async throws -> APIResponse {
        await genericCall(url, requestData, "PUT", authentication)
    }

    func delete(
        url: URL,
        requestData: Data? = nil,
        authentication: Bool = true
    ) async throws -> APIResponse {
        await genericCall(url, requestData, "DELETE", authentication)
    }

    private func genericCall(
        _ url: URL,
        _ requestData: Data? = nil,
        _ method: String,
        _ authentication: Bool
    ) async -> APIResponse {
        guard Reachability.isConnectedToNetwork() else {
            return APIResponse(nil, nil, .noNetwork)
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = requestData

        if let token: String = helper.read(), authentication {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                return APIResponse(data, 500, .badServerResponse)
            }

            print("----Api Call-----------", "\(method) \(url) \(httpResponse.statusCode)")
            return APIResponse(data, httpResponse.statusCode, nil)

        } catch {
            print("Receiver error \(error)")
            return APIResponse(nil, nil, .badServerResponse)
        }
    }
}
