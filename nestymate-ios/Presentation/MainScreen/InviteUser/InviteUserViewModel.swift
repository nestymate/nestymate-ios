//
//  InviteUserViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation
import SwiftUI

final class InviteUserViewModel: ObservableObject {
    private let useCase: HomeUseCase
    private let logoutService = LogoutService()
    @Published public var email: FieldModel = .init(value: "", fieldType: .email)
    @Published public var shouldShowLoader: Bool?
    @Published var error: HttpError?

    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }

    var shouldEnableButton: Bool {
        !email.value.isEmpty
    }

    @MainActor
    public func inviteUser() async throws -> Bool {
        shouldShowLoader = true
        do {
            _ = try await useCase.inviteUserToHome(email: email.value)
            shouldShowLoader = false
            return true
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return false
    }
}
