//
//  MainCoordinator.swift
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
    case createCategory(Category?)
    case createExpense(Int?)
    case myHome
    case signup
    case inviteUser
}

final class MainCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    private let loginService: LoginServiceImpl
    private let homeService: HomeServiceImpl
    private let expenseService: ExpenseServiceImpl
    private let categoryService: CategoryServiceImpl
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

    @MainActor
    init(navigationPath: Binding<NavigationPath>, output: Output? = nil, page: LoginPage) {
        _navigationPath = navigationPath
        id = UUID()
        self.output = output
        self.page = page

        loginService = LoginServiceImpl()
        homeService = HomeServiceImpl()
        expenseService = ExpenseServiceImpl()
        categoryService = CategoryServiceImpl()

        expenseUseCase = ExpenseUseCaseImpl(service: expenseService)
        homeUseCase = HomeUseCaseImpl(homeService: homeService)
        signUpUseCase = SignUpUseCaseImpl(service: loginService, homeService: homeService)
        mainScreenUseCase = MainScreenUseCaseImpl()
        categoryUseCase = CategoryUseCaseImpl(service: categoryService)
    }

    @ViewBuilder
    @MainActor
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
        case let .createCategory(category):
            createCategoryView(category: category)
        case let .createExpense(expenseId):
            createExpenseView(expenseId: expenseId)
        case .inviteUser:
            inviteUserView()
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    nonisolated static func == (
        lhs: MainCoordinator,
        rhs: MainCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
}

private extension MainCoordinator {
    @MainActor func loginView() -> some View {
        let viewModel = LoginViewModel(useCase: LoginUseCaseImpl(service: loginService, homeService: homeService))
        let loginView = LoginView(
            viewModel: viewModel,
            output:
            .init(
                goToMainScreen: {
                    self.push(
                        MainCoordinator(
                            navigationPath: self.$navigationPath,
                            page: .mainScreen
                        )
                    )
                },
                goToCreateHome: {
                    self.push(
                        MainCoordinator(
                            navigationPath: self.$navigationPath,
                            page: .createHome
                        )
                    )
                }, goToSignUp: {
                    self.push(
                        MainCoordinator(
                            navigationPath: self.$navigationPath,
                            page: .signup
                        )
                    )
                }
            )
        )
        return loginView
    }

    @MainActor func mainScreenView() -> some View {
        MainScreenView(viewModel: MainScreenViewModel(useCase: mainScreenUseCase),
                       output: MainScreenView.Output())
    }

    @MainActor func createHome() -> some View {
        let viewModel = CreateOrEditHomeViewModel(useCase: HomeUseCaseImpl(homeService: homeService), isEdit: false)
        return CreateOrEditHomeView(viewModel: viewModel, output: CreateOrEditHomeView.Output(goToMainScreen: {
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .mainScreen
                )
            )
        }, logout: {
            self.logout()
        }))
    }

    @MainActor func signUpView() -> some View {
        let viewModel = SignUpViewModel(useCase: signUpUseCase)
        return SignUpView(viewModel: viewModel, output: SignUpView.Output(goToMainScreen: {
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .mainScreen
                )
            )
        }, goToCreateHome: {
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createHome
                )
            )
        }))
    }

    @MainActor func myHomeView() -> some View {
        let viewModel = MyHomeViewModel(homeUseCase: homeUseCase, categoryUseCase: categoryUseCase)
        return MyHomeView(viewModel: viewModel, output: MyHomeView.Output(goBack: {
            self.goBack()
        }, goToCreateCategory: {
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createCategory(nil)
                )
            )
        }, goToEditCategory: { category in
            self.push(
                MainCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .createCategory(category)
                )
            )
        }, logout: {
            self.logout()
        }))
    }

    @MainActor func createCategoryView(category: Category?) -> some View {
        let viewModel = CreateOrEditCategoryViewModel(
            category: category,
            useCase: categoryUseCase,
            logoutService: logoutService
        )
        return CreateOrEditCategoryView(viewModel: viewModel, output: CreateOrEditCategoryView.Output(goBack: {
            self.goBack()
        }, logout: {
            self.logout()
        }))
    }

    @MainActor func createExpenseView(expenseId: Int?) -> some View {
        let viewModel = CreateOrEditExpenseViewModel(
            expenseId: expenseId,
            useCase: expenseUseCase,
            categoryUseCase: categoryUseCase,
            logoutService: logoutService
        )
        return CreateOrEditExpenseView(viewModel: viewModel, output: CreateOrEditExpenseView.Output(goBack: {
            self.goBack()
        }, logout: {
            self.logout()
        }))
    }

    @MainActor func inviteUserView() -> some View {
        let viewModel = InviteUserViewModel(useCase: homeUseCase)
        return InviteUserView(viewModel: viewModel, output: InviteUserView.Output(goBack: {
            self.goBack()
        }, logout: {
            self.logout()
        }))
    }

    @MainActor
    func logout() {
        push(
            MainCoordinator(
                navigationPath: $navigationPath,
                page: .login
            )
        )
    }

    func goBack() {
        navigationPath.removeLast()
    }

    func push(_ value: some Hashable) {
        navigationPath.append(value)
    }
}
