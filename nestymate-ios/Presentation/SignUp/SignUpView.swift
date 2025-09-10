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
                    title
                    name
                    surname
                    birthday
                    gender
                    username
                    password
                    repeatPassword
                    button
                    Spacer()
                }
            }
//            .onTapGesture {
//                let keyWindow = UIApplication.shared.connectedScenes
//                    .filter { $0.activationState == .foregroundActive }
//                    .map { $0 as? UIWindowScene }
//                    .compactMap { $0 }
//                    .first?.windows
//                    .filter { $0.isKeyWindow }.first
//                keyWindow?.endEditing(true)
//            }
            .background(ColorManager.backgroundColour)
            .hiddenNavigationBarStyle()
            .alert(item: $viewModel.error) { error in
                handleHttpErrorAlert(error: error)
            }
        }
    }
}

private extension SignUpView {
    var title: some View {
        Text(String(localized: "signup")).font(FontManager.title)
    }

    var name: some View {
        SingleTextField(fieldModel: $viewModel.name)
    }

    var surname: some View {
        SingleTextField(fieldModel: $viewModel.surname)
    }

    var birthday: some View {
        DatePickerUIView(title: String(localized: "select_birthday"), fieldModel: $viewModel.birthdate)
    }

    var gender: some View {
        SelectionPickerView(options: viewModel.genderOptions, fieldModel: $viewModel.gender)
    }

    var username: some View {
        SingleTextField(fieldModel: $viewModel.username)
    }

    var password: some View {
        PasswordTextField(fieldModel: $viewModel.password)
    }

    var repeatPassword: some View {
        PasswordTextField(fieldModel: $viewModel.repeatPassword)
    }

    var button: some View {
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
