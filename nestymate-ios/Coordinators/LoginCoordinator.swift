//
//  LoginCoordinator.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 1/5/24.
//

import Foundation
import SwiftUI

enum LoginPage {
    case login
    case mainScreen
    case createHome
    case createCategory
    case createExpense(Expense?)
    case myHome
    case signup
    case inviteUser
}

final class LoginCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    private let loginService = LoginServiceImpl()
    private let homeService = HomeServiceImpl()
    private let expenseService = ExpenseServiceImpl()
    private let logoutService = LogoutService()
    private let expenseUseCase: ExpenseUseCase
    private let homeUseCase: HomeUseCase
    private let signUpUseCase: SignUpUseCase
    private let mainScreenUseCase: MainScreenUseCase
    private let categoryUseCase: CategoryUseCase
    private var id: UUID
    private var output: Output?
    private var page: LoginPage

    struct Output {
        var goToMainScreen: () -> Void
    }

    init(navigationPath: Binding<NavigationPath>, output: Output? = nil, page: LoginPage) {
        _navigationPath = navigationPath
        id = UUID()
        self.output = output
        self.page = page

        expenseUseCase = ExpenseUseCaseImpl(service: expenseService)
        homeUseCase = HomeUseCaseImpl(homeService: homeService)
        signUpUseCase = SignUpUseCaseImpl(service: loginService, homeService: homeService)
        mainScreenUseCase = MainScreenUseCaseImpl()
        categoryUseCase = CategoryUseCaseImpl()
    }

    @ViewBuilder
    func view() -> some View {
        switch page {
        case .login:
            loginView()
        case .mainScreen:
            mainScreenView()
        case .createHome:
            createHome()
        case .signup:
            signUpView()
        case .myHome:
            myHomeView()
        case .createCategory:
            createCategoryView()
        case let .createExpense(expense):
            createExpenseView(expense: expense)
        case .inviteUser:
            inviteUserView()
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: LoginCoordinator,
        rhs: LoginCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
}

private extension LoginCoordinator {
    func loginView() -> some View {
        let viewModel = LoginViewModel(useCase: LoginUseCaseImpl(service: loginService, homeService: homeService))
        let loginView = LoginView(
            viewModel: viewModel,
            output:
            .init(
                goToMainScreen: {
                    self.push(
                        LoginCoordinator(
                            navigationPath: self.$navigationPath,
                            page: .mainScreen
                        )
                    )
                },
                goToCreateHome: {
                    self.push(
                        LoginCoordinator(
                            navigationPath: self.$navigationPath,
                            page: .createHome
                        )
                    )
                }, goToSignUp: {
                    self.push(
                        LoginCoordinator(
                            navigationPath: self.$navigationPath,
                            page: .signup
                        )
                    )
                }
            )
        )
        return loginView
    }

    func mainScreenView() -> some View {
        return MainScreenView(viewModel: MainScreenViewModel(useCase: mainScreenUseCase),
                              output: MainScreenView.Output())
    }

    func createHome() -> some View {
        let viewModel = CreateOrEditHomeViewModel(useCase: HomeUseCaseImpl(homeService: homeService), isEdit: false)
        return CreateOrEditHomeView(viewModel: viewModel, output: CreateOrEditHomeView.Output(goToMainScreen: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .mainScreen
                )
            )
        }, logout: {
            self.logout()
        }))
    }

    func signUpView() -> some View {
        let viewModel = SignUpViewModel(useCase: signUpUseCase)
        return SignUpView(viewModel: viewModel, output: SignUpView.Output(goToMainScreen: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .mainScreen
                )
            )
        }, goToCreateHome: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createHome
                )
            )
        }))
    }

    // FIXME: MOVE this to another coordinator
    func myHomeView() -> some View {
        let viewModel = MyHomeViewModel(homeUseCase: homeUseCase, categoryUseCase: categoryUseCase)
        return MyHomeView(viewModel: viewModel, output: MyHomeView.Output(goBack: {
            self.goBack()
        }, createCategory: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createCategory
                )
            )
        }, logout: {
            self.logout()
        }))
    }

    // FIXME: MOVE this to another coordinator
    func createCategoryView() -> some View {
        let viewModel = CreateCategoryViewModel(useCase: categoryUseCase)
        return CreateCategoryView(viewModel: viewModel, output: CreateCategoryView.Output(goBack: {
            self.goBack()
        }))
    }

    // FIXME: MOVE this to another coordinator
    func createExpenseView(expense: Expense?) -> some View {
        let viewModel = CreateOrEditExpenseViewModel(
            expense: expense,
            useCase: expenseUseCase,
            logoutService: logoutService
        )
        return CreateOrEditExpenseView(viewModel: viewModel, output: CreateOrEditExpenseView.Output(goBack: {
            self.goBack()
        }, logout: {
            self.logout()
        }))
    }

    // FIXME: MOVE this to another coordinator
    func inviteUserView() -> some View {
        let viewModel = InviteUserViewModel(useCase: homeUseCase)
        return InviteUserView(viewModel: viewModel, output: InviteUserView.Output(goBack: {
            self.goBack()
        }, logout: {
            self.logout()
        }))
    }

    func logout() {
        push(
            LoginCoordinator(
                navigationPath: $navigationPath,
                page: .login
            )
        )
    }

    func goBack() {
        navigationPath.removeLast()
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}
