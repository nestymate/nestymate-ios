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
            get: { self.viewModel.shouldShowLoader ?? false },
            set: { self.viewModel.shouldShowLoader = $0 }
        )) {
            ScrollView {
                VStack {
                    Text("New Home").font(FontManager.title)
                    SingleTextField(fieldModel: $viewModel.name)
                        .onSubmit {
                            _ = viewModel.name.onSubmitError()
                        }
                    SingleTextField(fieldModel: $viewModel.description)
                        .onSubmit {
                            _ = viewModel.description.onSubmitError()
                        }
                    SingleTextField(fieldModel: $viewModel.address)
                        .onSubmit {
                            _ = viewModel.address.onSubmitError()
                        }
                    ActionButton(title: "Create") {
                        viewModel.createHome {
                            self.output.goToMainScreen()
                        }
                    }
                    Spacer()
                }
            }
            .background(ColorManager.backgroundColour)
        }
    }
}

#Preview {
    CreateHomeView(output: CreateHomeView.Output(goToMainScreen: {}))
}
