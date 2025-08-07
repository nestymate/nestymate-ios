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
    private let expenseService = ExpenseServiceImpl()
    private let homeService = HomeServiceImpl()
    private let logoutService = LogoutService()
    private let expenseUseCase: ExpenseUseCase
    private let homeUseCase: HomeUseCase
    private let mainScreenUseCase: MainScreenUseCase
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
        expenseUseCase = ExpenseUseCaseImpl(service: expenseService)
        homeUseCase = HomeUseCaseImpl(homeService: homeService)
        mainScreenUseCase = MainScreenUseCaseImpl()
    }

    @MainActor
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
    @MainActor func mainScreenView() -> some View {
        MainScreenView(viewModel: MainScreenViewModel(useCase: mainScreenUseCase), output: .init())
    }

    @MainActor func expensesView() -> some View {
        let viewModel = ExpensesViewModel(
            useCase: expenseUseCase,
            homeUseCase: homeUseCase,
            logoutService: logoutService
        )
        return ExpensesView(viewModel: viewModel, output: ExpensesView.Output(goToMyHome: {
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .myHome
                )
            )
        }, goToCreateExpense: {
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createExpense(nil)
                )
            )
        }, goToEditExpense: { expenseId in
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createExpense(expenseId)
                )
            )
        }, logout: {
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .login
                )
            )
        }))
    }

    func push(_ value: some Hashable) {
        navigationPath.append(value)
    }
}
