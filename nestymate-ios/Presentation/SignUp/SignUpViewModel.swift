//
//  SignUpViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    @Published public var username: FieldModel = .init(value: "", fieldType: .username)
    @Published public var name: FieldModel = .init(value: "", fieldType: .name)
    @Published public var surname: FieldModel = .init(value: "", fieldType: .surname)
    @Published public var password: FieldModel = .init(value: "", fieldType: .password)
    @Published public var repeatPassword: FieldModel = .init(value: "", fieldType: .repeatPassword)
    @Published public var birthdate: FieldModel = .init(value: "", fieldType: .birthday)
    @Published public var gender: FieldModel = .init(value: "", fieldType: .gender)
    @Published public var shouldShowLoader: Bool?
    @Published public var shouldShowErrorPassword: Bool?
    @Published public var shouldShowErrorEmail: Bool?
    @Published var error: Error?
    var shouldEnableButton: Bool {
        !username.value.isEmpty
            && !password.value.isEmpty
            && !repeatPassword.value.isEmpty
    }

    var genderOptions = ["male", "female", "other"]
    private var useCase: SignUpUseCase

    init(useCase: SignUpUseCase) {
        shouldShowErrorEmail = false
        shouldShowErrorPassword = false
        shouldShowLoader = false
        self.useCase = useCase
    }

    public func signUp(completionHandler: @escaping () -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let user = User(
            username: username.value,
            password: password.value,
            repeatPassword: repeatPassword.value,
            name: name.value,
            surname: surname.value,
            birthday: formatter.string(from: birthdate.dateValue),
            gender: gender.value
        )
        print("isValid", user.isValid)
        print("isPasswordsTheSame", user.isPasswordsTheSame)
        if useCase.isSignupValid(user: user) {
            shouldShowLoader = true
            useCase.signUp(user: user) { [weak self] apiError in
                self?.shouldShowLoader = false
                self?.error = apiError
                if apiError == nil {
                    completionHandler()
                }
            }
        } else {
            shouldShowErrorPassword = true
        }
    }
}
