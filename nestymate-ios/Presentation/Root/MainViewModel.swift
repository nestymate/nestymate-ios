//
//  MainViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    let keyChain = KeychainHelper()
    var shouldShowLogin: LoginPage {
        guard keyChain.read() != nil else { return .login }
        return .mainScreen
    }
}
