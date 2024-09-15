//
//  AppCoordinator.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 5/5/24.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath
    init(path: NavigationPath) {
        self.path = path
    }

    @ViewBuilder
    func view() -> some View {
        MainView(viewModel: MainViewModel())
    }
}
