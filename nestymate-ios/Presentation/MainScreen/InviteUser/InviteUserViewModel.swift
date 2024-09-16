//
//  InviteUserViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation
import SwiftUI

class InviteUserViewModel: ObservableObject {
    let useCase: HomeUseCase = HomeUseCaseImpl(homeService: HomeServiceImpl())
    private let logoutService = LogoutService()
    @Published public var email: FieldModel = .init(value: "", fieldType: .email)
    @Published public var shouldShowLoader: Bool?
    @Published var error: Error?

    var shouldEnableButton: Bool {
        !email.value.isEmpty
    }

    public func inviteUser(completionHandler: @escaping (Bool?) -> Void) {
        shouldShowLoader = true
        useCase.inviteUserToHome(email: email.value) { [weak self] error, statusCode in
            self?.shouldShowLoader = false
            self?.error = error
            completionHandler(self?.logoutService.shouldLogout(statusCode: statusCode))
        }
    }
}
