//
//  LoginViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    let useCase: LoginUseCase = LoginUseCaseImpl()
    @Published public var username: String?
    @Published public var password: String?

    public func login(username: String?, password: String?, completionHandler: @escaping () -> Void) {
        guard let username, let password else { return }
        useCase.login(username: username, password: password, completionHandler: completionHandler)
    }
}
