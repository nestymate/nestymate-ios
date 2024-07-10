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
    @Published public var shouldShow: Bool?

    @MainActor public func login(username: String?, password: String?, completionHandler: @escaping (Home?) -> Void) {
        guard let username, let password else { return }
        shouldShow = true
        useCase.login(username: username, password: password) { [weak self] in
            self?.useCase.checkHomeForUser { [weak self] home in
                self?.shouldShow = false
                completionHandler(home)
            }
        }
    }
}
