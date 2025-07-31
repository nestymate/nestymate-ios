//
//  LoginService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Combine
import Foundation

protocol LoginService: Sendable {
    func login(username: String, password: String) async throws -> HttpError?
    func signup(user: User) async throws -> HttpError?
}

final class LoginServiceImpl: LoginService {
    let mainUrl = URL(string: "http://192.168.1.10/auth")!
    let apiCall: APICalls

    init() {
        apiCall = APICalls()
    }

    @MainActor
    func login(username: String, password: String) async throws -> HttpError? {
        let url: URL = mainUrl.appending(path: "login")
        let data = try? JSONEncoder().encode(Login(username: username, password: password)) // "test123" "test321"
        let apiResponse = try await apiCall.post(url: url, requestData: data, authentication: false)
        if apiResponse.statusCode == 200 {
            guard let data = apiResponse.data,
                  let response = try? JSONDecoder().decode(Response.self, from: data)
            else {
                return .badServerResponse
            }

            print("We received token -------", response.token)
            let helper = KeychainHelper()
            helper.save(Data(response.token.utf8))
            return apiResponse.error

        } else if apiResponse.statusCode == 401 {
            return .passwordAndUserNameDidNotMatch
        } else {
            return .badServerResponse
        }
    }

    func signup(user: User) async throws -> HttpError? {
        let url: URL = mainUrl.appending(path: "signup")
        let data = try? JSONEncoder().encode(user)
        let apiResponse = try await apiCall.post(url: url, requestData: data, authentication: false)
        guard let data = apiResponse.data,
              let response = try? JSONDecoder().decode(Response.self, from: data)
        else {
            return .badServerResponse
        }
        print(response.token)
        let helper = KeychainHelper()
        helper.save(Data(response.token.utf8))
        return apiResponse.error
    }
}
