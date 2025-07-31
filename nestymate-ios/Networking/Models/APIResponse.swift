//
//  APIResponse.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 17/7/24.
//

import Foundation

struct APIResponse {
    let data: Data?
    let statusCode: Int?
    let error: HttpError?

    public init(_ data: Data?, _ statusCode: Int?, _ error: HttpError?) {
        self.data = data
        self.statusCode = statusCode
        self.error = error
    }
}
