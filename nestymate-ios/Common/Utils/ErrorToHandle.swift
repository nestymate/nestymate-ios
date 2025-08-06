//
//  ErrorToHandle.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 6/8/25.
//

public struct ErrorToHandle: Decodable, Error {
    let title: String
    let status: Int
    let detail: String
}
