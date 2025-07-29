//
//  ProfileUseCase.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/7/24.
//

import Foundation

protocol ProfileUseCase: Sendable {
    func logout(completionHandler: @escaping () -> Void)
}

final class ProfileUseCaseImpl: ProfileUseCase {
    func logout(completionHandler: @escaping () -> Void) {
        let helper = KeychainHelper()
        helper.delete()
        completionHandler()
    }
}
