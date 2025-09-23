//
//  Home.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation

struct Home: Encodable, Decodable, Sendable, Identifiable {
    let id: Int
    let name: String
    let active: Bool
    let description: String?
    let address: String?
}

struct HomeReference: Decodable {
    let reference: String
}
