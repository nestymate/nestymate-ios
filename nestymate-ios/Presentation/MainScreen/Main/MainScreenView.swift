//
//  MainScreenView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct MainScreenView: View {
    var viewModel: MainScreenViewModel = .init()
    @EnvironmentObject var appCoordinator: AppCoordinator
    struct Output {}
    var output: Output
    var body: some View {
        TabView {
            ExpensesCoordinator(
                navigationPath: $appCoordinator.path,
                output: .init(
                    goToMainScreen: {
                        print("Go to main screen (MainTabView)")
                    }
                ),
                page: .expenses
            ).view()
                .tabItem {
                    Label("Expenses", systemImage: "list.dash")
                }
            HomeScreenCoordinator(
                navigationPath: $appCoordinator.path,
                output: .init(
                    goToMainScreen: {
                        print("Go to main screen (MainTabView)")
                    }
                ),
                page: .profile
            ).view()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainScreenView(output: MainScreenView.Output())
}
