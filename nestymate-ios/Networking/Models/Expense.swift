//
//  Expense.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

public struct Expense: Encodable, Decodable {
    public let title: String?
    public let description: String
    public let amount: Double
}
