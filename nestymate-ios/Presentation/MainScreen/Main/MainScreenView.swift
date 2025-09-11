//
//  MainScreenView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct MainScreenView: View {
    var viewModel: MainScreenViewModel
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
                    Label(String(localized: "expenses"), systemImage: "list.dash")
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
                    Label(String(localized: "profile"), systemImage: "square.and.pencil")
                }
        }
        .onOpenURL { incomingURL in
            print("App was opened via URL: \(incomingURL)")
            handleIncomingURL(incomingURL)
        }
        .navigationBarBackButtonHidden()
        .background(ColorManager.backgroundColour)
    }

    // nestymate://invite?code=002f8bea-848d-4f0d-b05a-5e559114bea2
    private func handleIncomingURL(_ url: URL) {
        guard url.scheme == "nestymate" else {
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

        guard let reference = components.queryItems?.first(where: { $0.name == "code" })?.value else {
            print("Code not found")
            return
        }

        print(reference)
    }
}

#Preview {
    MainScreenView(viewModel: MainScreenViewModel(useCase: MainScreenUseCaseImpl()), output: MainScreenView.Output())
}
