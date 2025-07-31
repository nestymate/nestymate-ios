//
//  SuccessResponse.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 31/7/25.
//

struct SuccessResponse: Sendable {
    let success: Bool
    let error: HttpError?
}
