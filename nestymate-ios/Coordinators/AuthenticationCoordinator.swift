//
//  AuthenticationCoordinator.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 1/5/24.
//

import Foundation
import SwiftUI

enum LoginPage {
    case login
    case mainScreen
}

final class AuthenticationCoordinator: Hashable {
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
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: AuthenticationCoordinator,
        rhs: AuthenticationCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
}

private extension AuthenticationCoordinator {
    func loginView() -> some View {
        let loginView = LoginView(
            output:
            .init(
                goToMainScreen: {
                    self.push(
                        AuthenticationCoordinator(
                            navigationPath: self.$navigationPath,
                            page: .mainScreen
                        )
                    )
                }
            )
        )
        return loginView
    }

    func mainScreenView() -> some View {
        return MainScreenView()
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}
