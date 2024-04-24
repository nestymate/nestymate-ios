//
//  MainScreenView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import SwiftUI

struct MainScreenView: View {
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
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainScreenView()
}
