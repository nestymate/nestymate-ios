//
//  ProfileViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/7/24.
//

import Foundation

final class ProfileViewModel {
    let useCase: ProfileUseCase = ProfileUseCaseImpl()
    func logout(completionHandler: @escaping () -> Void) {
        useCase.logout(completionHandler: completionHandler)
    }
}
