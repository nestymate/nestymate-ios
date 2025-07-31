//
//  LoginServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 21/11/24.
//
import Foundation

final class LoginServiceFailedMock: LoginService {
    func login(username _: String, password _: String) async throws -> HttpError? {
        HttpError.badServerResponse
    }

    func signup(user _: User) async throws -> HttpError? {
        HttpError.badServerResponse
    }
}
