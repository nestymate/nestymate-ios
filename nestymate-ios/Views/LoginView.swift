//
//  LoginView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 18/4/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = .init()
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
                Text("login").font(FontManager.title)
                SingleTextField(fieldModel: $viewModel.username).onSubmit {
                    _ = viewModel.username.onSubmitError()
                }
                PasswordTextField(fieldModel: $viewModel.password).onSubmit {
                    _ = viewModel.password.onSubmitError()
                }

                ActionButton(title: "login") {
                    viewModel.login { home in
                        home == nil ? self.output.goToCreateHome() : self.output.goToMainScreen()
                    }
                }
                HStack {
                    Text("New to Nestymate?").font(FontManager.button)
                    Button {
                        self.output.goToSignUp()
                    } label: {
                        Text("Sign up here")
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
        }
    }
}

#Preview {
    LoginView(viewModel: .init(), output: LoginView.Output(goToMainScreen: {}, goToCreateHome: {}, goToSignUp: {}))
}
