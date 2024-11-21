//
//  HomeServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 22/11/24.
//

import Foundation

final class HomeServiceMock: HomeService {
    func inviteUserToHome(email _: String, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }

    func createHome(home _: Home, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }

    func editHome(home _: Home, completionHandler: @escaping (Error?, Int?) -> Void) {
        completionHandler(nil, 200)
    }

    func getHome(completionHandler: @escaping (Home?, Error?, Int?) -> Void) {
        completionHandler(Home(id: 0, name: "", description: "", address: ""), nil, 200)
    }
}
