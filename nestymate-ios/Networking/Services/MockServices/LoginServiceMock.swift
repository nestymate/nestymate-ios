//
//  LoginServiceMock.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 21/11/24.
//
import Foundation

final class LoginServiceMock: LoginService {
    func login(username _: String, password _: String) async throws -> Error? {
        nil
    }

    func signup(user _: User) async throws -> Error? {
        nil
    }
}
