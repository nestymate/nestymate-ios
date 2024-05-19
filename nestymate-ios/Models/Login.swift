//
//  Login.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation

struct Login: Encodable {
    let username: String
    let password: String
}

struct Response: Decodable {
    let token: String
}
