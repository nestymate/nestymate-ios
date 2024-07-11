//
//  SignUpViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 11/7/24.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published public var email: FieldModel = .init(value: "", fieldType: .email)
    @Published public var password: FieldModel = .init(value: "", fieldType: .password)
    @Published public var repeatPassword: FieldModel = .init(value: "", fieldType: .repeatPassword)

    @Published public var shouldShowLoader: Bool?
    @Published public var shouldShowErrorPassword: Bool?
    @Published public var shouldShowErrorEmail: Bool?
    private var useCase: SignUpUseCase = SignUpUseCaseImpl()

    init() {
        shouldShowErrorEmail = false
        shouldShowErrorPassword = false
        shouldShowLoader = false
    }

    public func signUp(completionHandler: @escaping () -> Void) {
        if useCase.signUpValid(
            isEmailValid: email.onValidate(),
            isPasswordValid: password.onValidate(),
            isRepeatPasswordValid: repeatPassword.onValidate()
        ) {
            useCase.signUp { [weak self] in
                self?.shouldShowLoader = false
                completionHandler()
            }
        } else {
            shouldShowErrorPassword = true
        }
    }
}
