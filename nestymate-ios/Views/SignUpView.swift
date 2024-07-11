//
//  SignUpView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel = .init()
    struct Output {
        var goToMainScreen: () -> Void
    }

    var output: Output
    var body: some View {
        ActivityIndicatorIView(isShowing: Binding<Bool>(
            get: { self.viewModel.shouldShowLoader ?? false },
            set: { self.viewModel.shouldShowLoader = $0 }
        )) {
            ScrollView {
                VStack {
                    Text("Sign up").font(FontManager.title)
                    SingleTextField(fieldModel: $viewModel.email)
                        .onSubmit {
                            _ = viewModel.email.onSubmitError()
                        }
                    PasswordTextField(fieldModel: $viewModel.password).onSubmit {
                        _ = viewModel.password.onSubmitError()
                    }
                    PasswordTextField(fieldModel: $viewModel.repeatPassword)
                        .onSubmit {
                            _ = viewModel.repeatPassword.onSubmitError()
                        }
                    ActionButton(title: "Sign up") {
                        viewModel.signUp {
                            self.output.goToMainScreen()
                        }
                    }
                    Spacer()
                }
            }
            .background(ColorManager.backgroundColour)
        }
    }
}

#Preview {
    SignUpView(output: SignUpView.Output(goToMainScreen: {}))
}
