//
//  Expense.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

public struct Expense: Encodable, Decodable {
    public let id: Int
    public let title: String?
    public let description: String
    public let amount: Double
    public let categoryId: Int

    init(id: Int, title: String?, description: String, amount: Double, categoryId: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.amount = amount
        self.categoryId = categoryId
    }

    init() {
        id = 0
        title = ""
        description = ""
        amount = 0
        categoryId = 0
    }
}
