//
//  CreateHomeView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import SwiftUI

struct CreateHomeView: View {
    @ObservedObject var viewModel: CreateHomeViewModel = .init()
    struct Output {
        var goToMainScreen: () -> Void
    }

    var output: Output
    var body: some View {
        ActivityIndicatorIView(isShowing: Binding<Bool>(
            get: { self.viewModel.shouldShow ?? false },
            set: { self.viewModel.shouldShow = $0 }
        )) {
            VStack {
                Text("New Home").font(FontManager.title)
                SingleTextField(title: "name", value: Binding<String>(
                    get: { self.viewModel.name ?? "" },
                    set: { self.viewModel.name = $0 }))
                SingleTextField(title: "description", value: Binding<String>(
                    get: { self.viewModel.description ?? "" },
                    set: { self.viewModel.description = $0 }))
                SingleTextField(title: "address", value: Binding<String>(
                    get: { self.viewModel.address ?? "" },
                    set: { self.viewModel.address = $0 }))
                ActionButton(title: "Create") {
                    viewModel.createHome(
                        name: viewModel.name,
                        description: viewModel.description,
                        address: viewModel.address
                    ) {
                        self.output.goToMainScreen()
                    }
                }
                Spacer()
            }
            .background(ColorManager.backgroundColour)
        }
    }
}

#Preview {
    CreateHomeView(output: CreateHomeView.Output(goToMainScreen: {}))
}
