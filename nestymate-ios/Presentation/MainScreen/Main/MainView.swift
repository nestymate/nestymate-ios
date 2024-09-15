//
//  MainView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 5/5/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator

    var body: some View {
        Group {
            LoginCoordinator(
                navigationPath: $appCoordinator.path,
                output: .init(
                    goToMainScreen: {
                        print("Go to main screen (MainTabView)")
                    }
                ),
                page: .login
            ).view()
        }
    }
}

#Preview {
    MainView()
}
