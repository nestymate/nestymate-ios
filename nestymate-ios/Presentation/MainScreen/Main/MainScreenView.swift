//
//  MainScreenView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct MainScreenView: View {
    var viewModel: MainScreenViewModel = .init()
    @EnvironmentObject var appCoordinator: AppCoordinator
    struct Output {}
    var output: Output
    var body: some View {
        TabView {
            ExpensesCoordinator(
                navigationPath: $appCoordinator.path,
                output: .init(
                    goToMainScreen: {
                        print("Go to main screen (MainTabView)")
                    }
                ),
                page: .expenses
            ).view()
                .tabItem {
                    Label("Expenses", systemImage: "list.dash")
                }
            HomeScreenCoordinator(
                navigationPath: $appCoordinator.path,
                output: .init(
                    goToMainScreen: {
                        print("Go to main screen (MainTabView)")
                    }
                ),
                page: .profile
            ).view()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .onOpenURL { incomingURL in
            print("App was opened via URL: \(incomingURL)")
            handleIncomingURL(incomingURL)
        }
        .navigationBarBackButtonHidden()
    }

    // nestymateapp://invite?reference=home123
    private func handleIncomingURL(_ url: URL) {
        guard url.scheme == "nestymateapp" else {
            return
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL")
            return
        }

        guard let action = components.host, action == "invite" else {
            print("Unknown URL, we can't handle this one!")
            return
        }

        guard let reference = components.queryItems?.first(where: { $0.name == "reference" })?.value else {
            print("Recipe name not found")
            return
        }

        print(reference)
    }
}

#Preview {
    MainScreenView(output: MainScreenView.Output())
}
