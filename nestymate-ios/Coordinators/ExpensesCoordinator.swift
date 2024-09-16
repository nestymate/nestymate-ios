//
//  ExpensesCoordinator.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import Foundation
import SwiftUI

enum ExpensesPage {
    case mainScreen
    case expenses
}

final class ExpensesCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    private var id: UUID
    private var output: Output?
    private var page: ExpensesPage
    struct Output {
        var goToMainScreen: () -> Void
    }

    init(navigationPath: Binding<NavigationPath>, output: Output? = nil, page: ExpensesPage) {
        _navigationPath = navigationPath
        id = UUID()
        self.output = output
        self.page = page
    }

    @ViewBuilder
    func view() -> some View {
        switch page {
        case .mainScreen:
            mainScreenView()
        case .expenses:
            expensesView()
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: ExpensesCoordinator,
        rhs: ExpensesCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
}

private extension ExpensesCoordinator {
    func mainScreenView() -> some View {
        return MainScreenView(output: .init())
    }

    func expensesView() -> some View {
        return ExpensesView(output: ExpensesView.Output(goToMyHome: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .myHome
                )
            )
        }, goToCreateExpense: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createExpense(nil)
                )
            )
        }, goToEditExpense: { expense in
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createExpense(expense)
                )
            )
        }, logout: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .login
                )
            )
        }))
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}
