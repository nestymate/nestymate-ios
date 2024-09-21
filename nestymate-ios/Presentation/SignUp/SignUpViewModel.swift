//
//  SignUpViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var username: FieldModel = .init(value: "", fieldType: .username)
    @Published var name: FieldModel = .init(value: "", fieldType: .name)
    @Published var surname: FieldModel = .init(value: "", fieldType: .surname)
    @Published var password: FieldModel = .init(value: "", fieldType: .password)
    @Published var repeatPassword: FieldModel = .init(value: "", fieldType: .repeatPassword)
    @Published var birthdate: FieldModel = .init(value: "", fieldType: .birthday)
    @Published var gender: FieldModel = .init(value: "", fieldType: .gender)
    @Published var shouldShowLoader: Bool?
    @Published var error: Error?

    var shouldEnableButton: Bool {
        !username.value.isEmpty
            && !password.value.isEmpty
            && !repeatPassword.value.isEmpty
    }

    var genderOptions = [String(localized: "male"),
                         String(localized: "female"),
                         String(localized: "other")]
    private var useCase: SignUpUseCase

    init(useCase: SignUpUseCase) {
        shouldShowLoader = false
        self.useCase = useCase
    }
}

extension SignUpViewModel {
    func signUp(completionHandler: @escaping (Home?) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = DateUtils.backendFormat
        let user = User(
            username: username.value,
            password: password.value,
            repeatPassword: repeatPassword.value,
            name: name.value,
            surname: surname.value,
            birthday: formatter.string(from: birthdate.dateValue),
            gender: gender.value
        )
        let (shouldProceed, signUpError) = useCase.shouldProceedToSignUp(user: user)
        if shouldProceed {
            shouldShowLoader = true
            useCase.signUp(user: user) { [weak self] errorLogin in
                self?.useCase.checkHomeForUser { [weak self] home, errorCheckHome, _ in
                    self?.shouldShowLoader = false
                    let apiError = errorLogin ?? errorCheckHome ?? nil
                    self?.error = apiError
                    if apiError == nil {
                        completionHandler(home)
                    }
                }
            }
        } else {
            error = signUpError
        }
    }
}
