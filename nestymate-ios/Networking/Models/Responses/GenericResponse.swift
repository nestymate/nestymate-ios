//
//  GenericResponse.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/7/25.
//

struct GenericResponse: Sendable {
    let error: HttpError?
    let statusCode: Int?
}
