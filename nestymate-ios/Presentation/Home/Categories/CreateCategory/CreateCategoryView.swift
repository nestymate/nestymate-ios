//
//  CreateCategoryView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import SwiftUI

struct CreateCategoryView: View {
    @ObservedObject var viewModel: CreateCategoryViewModel
    struct Output {
        var goBack: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Text(String(localized: "create_category")).font(FontManager.title)
            SingleTextField(fieldModel: $viewModel.name)
            ActionButton(title: String(localized: "create"), shouldEnableButton: true) {
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
    CreateCategoryView(viewModel: CreateCategoryViewModel(useCase: CategoryUseCaseImpl()),
                       output: CreateCategoryView.Output(goBack: {}))
}
