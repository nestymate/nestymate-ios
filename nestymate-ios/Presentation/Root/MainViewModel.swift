//
//  MainViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    var shouldShowLogin: LoginPage {
        guard UserDefaults.standard.bool(forKey: "isLoggedIn") else { return .login }
        return .mainScreen
    }
}
