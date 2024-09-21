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
            get: { self.viewModel.shouldShow ?? false },
            set: { self.viewModel.shouldShow = $0 }
        )) {
            VStack {
                Text(String(localized: "login")).font(FontManager.title)
                SingleTextField(fieldModel: $viewModel.username)
                PasswordTextField(fieldModel: $viewModel.password)
                ActionButton(
                    title: String(localized: "login"),
                    shouldEnableButton: viewModel.shouldEnableButton
                ) {
                    viewModel.login { home in
                        home == nil ? self.output.goToCreateHome() : self.output.goToMainScreen()
                    }
                }
                HStack {
                    Text(String(localized: "new_to_nestymate")).font(FontManager.button)
                    Button {
                        self.output.goToSignUp()
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
                error.alert
            }
        }
    }
}

#Preview {
    LoginView(viewModel: .init(
        useCase: LoginUseCaseImpl(
            service: LoginServiceImpl(),
            homeService: HomeServiceImpl()
        )),
    output: LoginView.Output(goToMainScreen: {},
                             goToCreateHome: {}, goToSignUp: {}))
}
