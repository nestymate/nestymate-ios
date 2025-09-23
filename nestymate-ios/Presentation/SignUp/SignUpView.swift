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
            get: { viewModel.shouldShowLoader ?? false },
            set: { viewModel.shouldShowLoader = $0 }
        )) {
            ScrollView {
                VStack {
                    Text(String(localized: "signup")).font(FontManager.title)
                    SingleTextField(fieldModel: $viewModel.name)
                    SingleTextField(fieldModel: $viewModel.surname)
                    DatePickerUIView(title: String(localized: "select_birthday"), fieldModel: $viewModel.birthdate)
                    SelectionPickerView(options: viewModel.genderOptions, fieldModel: $viewModel.gender)
                    SingleTextField(fieldModel: $viewModel.username)
                    PasswordTextField(fieldModel: $viewModel.password)
                    PasswordTextField(fieldModel: $viewModel.repeatPassword)
                    ActionButton(
                        title: String(localized: "signup"),
                        shouldEnableButton: viewModel.shouldEnableButton
                    ) {
                        Task {
                            let result = try await viewModel.signUp()
                            guard result.success else { return }
                            if !result.shouldShowHome {
                                output.goToMainScreen()
                            } else {
                                output.goToCreateHome()
                            }
                        }
                    }
                    Spacer()
                }
            }
            .background(ColorManager.backgroundColour)
            .hiddenNavigationBarStyle()
            .alert(item: $viewModel.error) { error in
                handleHttpErrorAlert(error: error)
            }
        }
    }
}

#Preview {
    let useCase = SignUpUseCaseImpl(
        service: LoginServiceImpl(),
        homeService: HomeServiceImpl()
    )
    let homeUseCase = HomeUseCaseImpl(homeService: HomeServiceImpl())
    SignUpView(viewModel: SignUpViewModel(useCase: useCase, homeUseCase: homeUseCase),
               output: SignUpView.Output(goToMainScreen: {}, goToCreateHome: {}))
}
