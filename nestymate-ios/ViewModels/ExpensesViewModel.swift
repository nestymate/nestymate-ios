//
//  ExpensesViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 14/9/24.
//

import Foundation
class ExpensesViewModel: ObservableObject {
    public var expenses = [
        Expense(name: "expense 1"),
        Expense(name: "expense 2"),
        Expense(name: "expense 3"),
        Expense(name: "expense 4")
    ]
}
