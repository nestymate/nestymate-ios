//
//  MainScreenView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct MainScreenView: View {
    var viewModel: MainScreenViewModel = .init()
    struct Output {}

    var output: Output
    var body: some View {
        TabView {
            ExpensesView()
                .tabItem {
                    Label("Expenses", systemImage: "list.dash")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .onAppear(perform: {})
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainScreenView(output: MainScreenView.Output())
}
