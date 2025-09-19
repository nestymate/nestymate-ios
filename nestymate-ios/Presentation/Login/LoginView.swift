//
//  LoginView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 18/4/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    struct Output {
        var goToMainScreen: () -> Void
        var goToCreateHome: () -> Void
        var goToSignUp: () -> Void
    }

    var output: Output
    var body: some View {
        ActivityIndicatorIView(isShowing: Binding<Bool>(
            get: { viewModel.shouldShow ?? false },
            set: { viewModel.shouldShow = $0 }
        )) {
            VStack {
                Text(String(localized: "login")).font(FontManager.title)
                SingleTextField(fieldModel: $viewModel.username)
                PasswordTextField(fieldModel: $viewModel.password)
                ActionButton(
                    title: String(localized: "login"),
                    shouldEnableButton: viewModel.shouldEnableButton
                ) {
                    Task {
                        let result = try await viewModel.login()
                        guard result.success else { return }
                        if !result.shouldShowHome {
                            output.goToMainScreen()
                        } else {
                            output.goToCreateHome()
                        }
                    }
                }
                HStack {
                    Text(String(localized: "new_to_nestymate")).font(FontManager.button)
                    Button {
                        output.goToSignUp()
                    } label: {
                        Text(String(localized: "signup_here"))
                            .foregroundColor(ColorManager.linkColour)
                            .underline()
                            .font(FontManager.button)
                    }
                }
                Spacer()
            }
            .padding([.top], 64)
            .background(ColorManager.backgroundColour)
            .navigationBarBackButtonHidden()
            .alert(item: $viewModel.error) { error in
                handleHttpErrorAlert(error: error)
            }
            .onOpenURL { incomingURL in
                print("App was opened via URL: \(incomingURL)")
                Task {
                    try await handleIncomingURL(incomingURL)
                }
            }
        }
    }

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

        viewModel.save(inviteCode: inviteCode)
    }
}

#Preview {
    LoginView(viewModel: .init(
        useCase: LoginUseCaseImpl(
            service: LoginServiceImpl(),
            homeService: HomeServiceImpl()
        ), homeUseCase: HomeUseCaseImpl(homeService: HomeServiceImpl())
    ),
    output: LoginView.Output(goToMainScreen: {},
                             goToCreateHome: {}, goToSignUp: {}))
}
