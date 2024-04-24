//
//  ContentView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 18/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView(output: LoginView.Output(goToMainScreen: {}))
    }
}

#Preview {
    ContentView()
}
