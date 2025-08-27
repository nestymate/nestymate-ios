//
//  Home.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation

struct Home: Encodable, Decodable, Sendable {
    let id: Int
    let name: String
    let description: String
    let address: String
    let active: Bool
}

struct HomeReference: Decodable {
    let reference: String
}
