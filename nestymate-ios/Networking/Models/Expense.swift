//
//  Expense.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

public struct Expense: Encodable, Decodable, Sendable {
    public let id: Int
    public let title: String?
    public let amount: Double
    public let date: String?
    public let description: String?
    public let expenseCategory: Category?
    public let expenseCategoryId: Int?
    public let participatingUserIds: [Int]?

    init(
        id: Int,
        title: String?,
        amount: Double,
        date: String?,
        description: String?,
        expenseCategory: Category? = nil,
        expenseCategoryId: Int?,
        participatingUserIds: [Int]?
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.date = date
        self.description = description
        self.expenseCategory = expenseCategory
        self.expenseCategoryId = expenseCategoryId
        self.participatingUserIds = participatingUserIds
    }

    init() {
        id = 0
        title = ""
        description = ""
        amount = 0
        expenseCategory = nil
        expenseCategoryId = nil
        date = ""
        participatingUserIds = []
    }
}
