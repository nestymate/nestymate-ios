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
    case signup
}

final class LoginCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
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
        let loginView = LoginView(
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
        return MainScreenView(output:
            .init()
        )
    }

    func createHome() -> some View {
        return CreateHomeView(output: CreateHomeView.Output(goToMainScreen: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .mainScreen
                )
            )
        }))
    }

    func signUpView() -> some View {
        return SignUpView(output: SignUpView.Output(goToMainScreen: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .mainScreen
                )
            )
        }))
    }

    func popLast() {
        navigationPath.removeLast()
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}
