//
//  HomeServiceFailedMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 22/11/24.
//

import Foundation

final class HomeServiceFailedMock: HomeService {
    func inviteUserToHome(email _: String, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 500)
    }

    func createHome(home _: Home, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 500)
    }

    func editHome(home _: Home, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 500)
    }

    func getHome(completionHandler: @escaping (Home?, Error?, Int?) -> Void) {
        completionHandler(nil, .badServerResponse, 500)
    }
}
