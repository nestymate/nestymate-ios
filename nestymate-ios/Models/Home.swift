//
//  Home.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation

struct Home: Encodable, Decodable {
    let reference: String
    let name: String
    let description: String
    let address: String
}

struct HomeResponse: Decodable {
    let reference: String
}
