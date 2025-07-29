//
//  CategoriesResponse.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/7/25.
//

struct CategoriesResponse: Sendable {
    let categories: [Category]?
    let statusCode: Int?
    let shouldLogout: Bool
}
