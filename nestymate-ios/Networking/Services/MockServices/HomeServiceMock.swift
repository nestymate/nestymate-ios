//
//  HomeServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 22/11/24.
//

import Foundation

final class HomeServiceMock: HomeService {
    private let hasHome: Bool

    init(hasHome: Bool) {
        self.hasHome = hasHome
    }

    func getActiveHome() async throws -> HomeResponse {
        if hasHome {
            HomeResponse(
                home: Home(id: 0, name: "", description: "", address: "", active: true),
                error: nil,
                statusCode: 200
            )
        } else {
            HomeResponse(home: nil, error: nil, statusCode: 200)
        }
    }

    func createHome(home _: Home) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func editHome(home _: Home) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func inviteUserToHome(email _: String) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }
}
