//
//  InviteUserViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation
import SwiftUI

class InviteUserViewModel: ObservableObject {
    let useCase: MyHomeUseCase = MyHomeUseCaseImpl(homeService: HomeServiceImpl())
    @Published public var email: FieldModel = .init(value: "", fieldType: .email)
    @Published public var shouldShowLoader: Bool?
    @Published var error: Error?

    var shouldEnableButton: Bool {
        !email.value.isEmpty
    }

    public func inviteUser(completionHandler: @escaping () -> Void) {
        shouldShowLoader = true
        useCase.inviteUserToHome(email: email.value) { [weak self] error in
            self?.shouldShowLoader = false
            self?.error = error
            completionHandler()
        }
    }
}
