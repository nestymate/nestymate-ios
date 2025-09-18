//
//  HomeResponse.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/7/25.
//

struct HomeResponse: Sendable {
    let home: Home?
    let error: HttpError?
    let statusCode: Int?
}

struct HomesResponse: Sendable {
    let homes: [Home]?
    let error: HttpError?
    let statusCode: Int?
}
