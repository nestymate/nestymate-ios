//
//  CreateCategoryView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import SwiftUI

struct CreateCategoryView: View {
    @ObservedObject var viewModel: CreateCategoryViewModel = .init()
    struct Output {
        var goBack: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Text("Create Category").font(FontManager.title)
            SingleTextField(fieldModel: $viewModel.name)
                .onSubmit {
                    _ = viewModel.name.onSubmitError()
                }
            ActionButton(title: "Create", shouldEnableButton: true) {
                viewModel.createCategory {
                    self.output.goBack()
                }
            }
            Spacer()
        }
        .background(ColorManager.backgroundColour)
    }
}

#Preview {
    CreateCategoryView(output: CreateCategoryView.Output(goBack: {}))
}
