//
//  HomeScreenCoordinator.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 1/5/24.
//

import Foundation
import SwiftUI

enum HomeScreenPage {
    case profile
}

final class HomeScreenCoordinator: Hashable {
    @Binding var navigationPath: NavigationPath
    private var id: UUID
    private var output: Output?
    private var page: HomeScreenPage

    struct Output {
        var goToMainScreen: () -> Void
    }

    init(navigationPath: Binding<NavigationPath>, output: Output? = nil, page: HomeScreenPage) {
        _navigationPath = navigationPath
        id = UUID()
        self.output = output
        self.page = page
    }

    @ViewBuilder
    func view() -> some View {
        switch page {
        case .profile:
            profile()
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (
        lhs: HomeScreenCoordinator,
        rhs: HomeScreenCoordinator
    ) -> Bool {
        lhs.id == rhs.id
    }
}

private extension HomeScreenCoordinator {
    func profile() -> some View {
        return ProfileView(output: ProfileView.Output(goToLogin: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .login
                )
            )
        }, goToInviteUser: {
            self.push(
                LoginCoordinator(
                    navigationPath: self.$navigationPath,
                    page: .inviteUser
                )
            )
        }))
    }

    func push<V>(_ value: V) where V: Hashable {
        navigationPath.append(value)
    }
}
