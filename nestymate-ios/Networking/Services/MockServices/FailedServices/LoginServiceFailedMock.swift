//
//  LoginServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 21/11/24.
//
import Foundation

final class LoginServiceFailedMock: LoginService {
    func login(username _: String, password _: String, completionHandler: @escaping (Error?) -> Void) {
        completionHandler(.badServerResponse)
    }

    func signup(user _: User, completionHandler: @escaping (Error?) -> Void) {
        completionHandler(.badServerResponse)
    }
}
