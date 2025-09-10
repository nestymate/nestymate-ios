//
//  UserResponse.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/9/25.
//

struct UserExpense: Decodable, Hashable {
    let id: Int
    let username: String
}

struct UserResponse: Sendable {
    let users: [UserExpense]?
    let error: HttpError?
    let statusCode: Int?
}
