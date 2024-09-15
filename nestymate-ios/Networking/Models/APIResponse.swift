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
    let error: Error?

    public init(_ data: Data?, _ statusCode: Int?, _ error: Error?) {
        self.data = data
        self.statusCode = statusCode
        self.error = error
    }
}
