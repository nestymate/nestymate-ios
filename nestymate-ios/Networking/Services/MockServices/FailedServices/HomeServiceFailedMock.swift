//
//  HomeServiceFailedMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 22/11/24.
//

import Foundation

final class HomeServiceFailedMock: HomeService {
    func getActiveHome() async throws -> HomeResponse {
        HomeResponse(home: nil, error: .badServerResponse, statusCode: 500)
    }

    func createHome(home _: Home) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func editHome(home _: Home) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }

    func inviteUserToHome(email _: String) async throws -> GenericResponse {
        GenericResponse(error: .badServerResponse, statusCode: 500)
    }
}
