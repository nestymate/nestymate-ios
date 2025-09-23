//
//  HomeServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 22/11/24.
//

import Foundation

final class HomeServiceMock: HomeService {
    private let home = Home(id: 0, name: "", active: true, description: "", address: "")
    private let hasHome: Bool

    init(hasHome: Bool) {
        self.hasHome = hasHome
    }

    func getActiveHome() async throws -> HomeResponse {
        if hasHome {
            HomeResponse(
                home: home,
                error: nil,
                statusCode: 200
            )
        } else {
            HomeResponse(home: nil, error: nil, statusCode: 200)
        }
    }

    func getAllHomes() async throws -> HomesResponse {
        HomesResponse(homes: [home], error: nil, statusCode: 200)
    }

    func getHome(homeId _: Int) async throws -> HomeResponse {
        HomeResponse(home: home, error: nil, statusCode: 200)
    }

    func createHome(home _: Home) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func editHome(home _: Home) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func deleteHome(home _: Home) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func inviteUserToHome(homeId _: Int, email _: String) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }

    func acceptInvite(inviteCode _: String) async throws -> GenericResponse {
        GenericResponse(error: nil, statusCode: 200)
    }
}
