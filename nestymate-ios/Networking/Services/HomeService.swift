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
    func getAllHomes() async throws -> HomesResponse
    func getHome(homeId: Int) async throws -> HomeResponse
    func createHome(home: Home) async throws -> GenericResponse
    func editHome(home: Home) async throws -> GenericResponse
    func deleteHome(home: Home) async throws -> GenericResponse
    func inviteUserToHome(homeId: Int, email: String) async throws -> GenericResponse
    func acceptInvite(inviteCode: String) async throws -> GenericResponse
}

final class HomeServiceImpl: HomeService {
    let baseUrl = URL(string: "http://192.168.1.10/api/v1/user/home")!
    let homeUrl = URL(string: "http://192.168.1.10/api/v1/home")!
    let helper: KeychainHelper
    let apiCall: APICalls

    init() {
        apiCall = APICalls()
        helper = KeychainHelper()
    }

    func getActiveHome() async throws -> HomeResponse {
        do {
            let apiResponse = try await apiCall.get(url: baseUrl.appendingPathComponent("active"), requestData: nil)
            guard let data = apiResponse.data else { throw URLError(.badServerResponse) }
            let response = try? JSONDecoder().decode(Home.self, from: data)
            return HomeResponse(home: response, error: apiResponse.error, statusCode: apiResponse.statusCode)
        } catch {
            if let errorToHandle = error as? ErrorToHandle {
                return HomeResponse(home: nil, error: nil, statusCode: errorToHandle.status)
            } else {
                return HomeResponse(home: nil, error: .badServerResponse, statusCode: 500)
            }
        }
    }

    func getAllHomes() async throws -> HomesResponse {
        do {
            let apiResponse = try await apiCall.get(url: baseUrl, requestData: nil)
            guard let data = apiResponse.data else { throw URLError(.badServerResponse) }
            let response = try? JSONDecoder().decode([Home].self, from: data)
            return HomesResponse(homes: response, error: apiResponse.error, statusCode: apiResponse.statusCode)
        } catch {
            if let errorToHandle = error as? ErrorToHandle {
                return HomesResponse(homes: nil, error: nil, statusCode: errorToHandle.status)
            } else {
                return HomesResponse(homes: nil, error: .badServerResponse, statusCode: 500)
            }
        }
    }

    func getHome(homeId: Int) async throws -> HomeResponse {
        let url = homeUrl.appendingPathComponent(String(homeId))
        let apiResponse = try await apiCall.get(url: url, requestData: nil)
        guard let data = apiResponse.data else {
            throw URLError(.badServerResponse)
        }
        do {
            let home = try JSONDecoder().decode(Home.self, from: data)
            return HomeResponse(
                home: home,
                error: nil,
                statusCode: apiResponse.statusCode
            )
        } catch {
            throw URLError(.cannotDecodeRawData)
        }
    }

    func createHome(home: Home) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(home)
        let apiResponse = try await apiCall.post(url: baseUrl, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func editHome(home: Home) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(home)
        let putURL = homeUrl.appending(path: "\(home.id)")
        let apiResponse = try await apiCall.put(url: putURL, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func deleteHome(home: Home) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(home)
        let url = homeUrl.appendingPathComponent(String(home.id))
        let apiResponse = try await apiCall.delete(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func inviteUserToHome(homeId: Int, email: String) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(UserInvite(email: email))
        let url = homeUrl.appending(path: "\(homeId)").appendingPathComponent("invite")
        let apiResponse = try await apiCall.post(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }

    func acceptInvite(inviteCode: String) async throws -> GenericResponse {
        let data = try? JSONEncoder().encode(Invite(inviteCode: inviteCode))
        let url = homeUrl.appendingPathComponent("accept-invite")
        let apiResponse = try await apiCall.post(url: url, requestData: data)
        return GenericResponse(error: apiResponse.error, statusCode: apiResponse.statusCode)
    }
}
