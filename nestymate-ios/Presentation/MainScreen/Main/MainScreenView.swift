//
//  MainScreenView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var viewModel: MainScreenViewModel
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var showSuccessAlert = false
    struct Output {
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        ActivityIndicatorIView(isShowing: Binding<Bool>(
            get: { viewModel.shouldShowLoader ?? false },
            set: { viewModel.shouldShowLoader = $0 }
        )) {
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
        }
        .onOpenURL { incomingURL in
            print("App was opened via URL: \(incomingURL)")
            Task {
                try await handleIncomingURL(incomingURL)
            }
        }
        .alert(item: $viewModel.error) { error in
            handleHttpErrorAlert(error: error) {
                output.logout()
            }
        }
        .alert(String(localized: "You have joined a new home"), isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) {}
        }
        .navigationBarBackButtonHidden()
        .background(ColorManager.backgroundColour)
    }

    // nestymate://invite?code=002f8bea-848d-4f0d-b05a-5e559114bea2
    private func handleIncomingURL(_ url: URL) async throws {
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

        guard let inviteCode = components.queryItems?.first(where: { $0.name == "code" })?.value else {
            print("Code not found")
            return
        }

        print(inviteCode)
        let success = try await viewModel.acceptInvite(inviteCode: inviteCode)
        if success {
            showSuccessAlert = true
        }
    }
}

#Preview {
    MainScreenView(
        viewModel: MainScreenViewModel(
            useCase: MainScreenUseCaseImpl(),
            homeUseCase: HomeUseCaseImpl(homeService: HomeServiceImpl())
        ),
        output: MainScreenView.Output(logout: {})
    )
}
