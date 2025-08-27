//
//  HomeService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Combine
import Foundation

protocol HomeService: Sendable {
    func getActiveHome() async throws -> HomeResponse
    func createHome(home: Home) async throws -> GenericResponse
    func editHome(home: Home) async throws -> GenericResponse
    func inviteUserToHome(email: String) async throws -> GenericResponse
}

final class HomeServiceImpl: HomeService {
    let url = URL(string: "http://192.168.1.10/api/v1/user/home")!
    let helper: KeychainHelper
    let apiCall: APICalls

    init() {
        apiCall = APICalls()
        helper = KeychainHelper()
    }

    func getActiveHome() async throws -> HomeResponse {
        do {
            let apiResponse = try await apiCall.get(url: url.appendingPathComponent("active"), requestData: nil)
            guard let data = apiResponse.data else { throw URLError(.badServerResponse) }
            let response = try? JSONDecoder().decode(Home.self, from: data)
            return HomeResponse(home: response, error: apiResponse.error, statusCode: apiResponse.statusCode)
        } catch {
            if let errorToHandle = error as? ErrorToHandle, errorToHandle.status == 400 {
                return HomeResponse(home: nil, error: nil, statusCode: errorToHandle.status)
            } else {
                return HomeResponse(home: nil, error: .badServerResponse, statusCode: 500)
            }
        }
    }

    func createHome(home: Home) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(home)
        let apiResponse = try await apiCall.post(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func editHome(home: Home) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(home)
        let putURL = url.appending(path: "\(home.id)")
        let apiResponse = try await apiCall.put(url: putURL, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func inviteUserToHome(email: String) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(email)
        let apiResponse = try await apiCall.post(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }
}
