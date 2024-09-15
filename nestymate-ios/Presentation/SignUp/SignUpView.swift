//
//  SignUpView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    struct Output {
        var goToMainScreen: () -> Void
        var goToCreateHome: () -> Void
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
                    SingleTextField(fieldModel: $viewModel.name)
                        .onSubmit {
                            _ = viewModel.name.onSubmitError()
                        }
                    SingleTextField(fieldModel: $viewModel.surname)
                        .onSubmit {
                            _ = viewModel.surname.onSubmitError()
                        }
                    DatePickerUIView(title: "Please select your birthday", fieldModel: $viewModel.birthdate)
                    SelectionPickerView(options: viewModel.genderOptions, fieldModel: $viewModel.gender)
                    SingleTextField(fieldModel: $viewModel.username)
                        .onSubmit {
                            _ = viewModel.username.onSubmitError()
                        }
                    PasswordTextField(fieldModel: $viewModel.password).onSubmit {
                        _ = viewModel.password.onSubmitError()
                    }
                    PasswordTextField(fieldModel: $viewModel.repeatPassword)
                        .onSubmit {
                            _ = viewModel.repeatPassword.onSubmitError()
                        }
                    ActionButton(
                        title: "Sign up",
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        viewModel.signUp { home in
                            home == nil ? self.output.goToCreateHome() : self.output.goToMainScreen()
                        }
                    }
                    Spacer()
                }
            }
            .background(ColorManager.backgroundColour)
            .alert(item: $viewModel.error) { error in
                error.alert
            }
        }
    }
}

#Preview {
    let useCase = SignUpUseCaseImpl(
        service: LoginServiceImpl(),
        homeService: HomeServiceImpl()
    )
    return SignUpView(viewModel: SignUpViewModel(useCase: useCase),
                      output: SignUpView.Output(goToMainScreen: {}, goToCreateHome: {}))
}
