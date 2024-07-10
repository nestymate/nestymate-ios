//
//  Nestymate.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 18/4/24.
//

import SwiftUI

@main
struct Nestymate: App {
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath())

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                appCoordinator.view()
                    .navigationDestination(
                        for: LoginCoordinator.self
                    ) { coordinator in
                        coordinator.view()
                    }
            }
            .environmentObject(appCoordinator)
        }
    }
}
