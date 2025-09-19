//
//  MainScreenViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation
import SwiftUI

final class MainScreenViewModel: ObservableObject {
    private let useCase: MainScreenUseCase
    private let homeUseCase: HomeUseCase
    @Published public var shouldShowLoader: Bool?
    @Published var error: HttpError?

    init(useCase: MainScreenUseCase, homeUseCase: HomeUseCase) {
        self.useCase = useCase
        self.homeUseCase = homeUseCase
    }

    var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    @MainActor
    public func acceptInvite(inviteCode: String) async throws -> Bool {
        shouldShowLoader = true
        do {
            _ = try await homeUseCase.acceptInvite(inviteCode: inviteCode)
            shouldShowLoader = false
            return true
        } catch {
            self.error = error as? HttpError
        }
        shouldShowLoader = false
        return false
    }
}
