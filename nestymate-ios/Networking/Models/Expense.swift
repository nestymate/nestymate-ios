//
//  Expense.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation

public struct Expense: Identifiable {
    public let id = UUID()
    public let name: String
}
