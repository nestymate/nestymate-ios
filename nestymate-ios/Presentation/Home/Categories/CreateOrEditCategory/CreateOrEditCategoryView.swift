//
//  CreateOrEditCategoryView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import SwiftUI

struct CreateOrEditCategoryView: View {
    @ObservedObject var viewModel: CreateOrEditCategoryViewModel
    struct Output {
        var goBack: () -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Text(viewModel.pageTitle).font(FontManager.title)
            SingleTextField(fieldModel: $viewModel.name)
            SingleTextField(fieldModel: $viewModel.description)
            ActionButton(title: viewModel.buttonTitle, shouldEnableButton: true) {
                viewModel.createOrUpdateCategory { shouldLogout in
                    guard let shouldLogout, !shouldLogout
                    else { return self.output.logout() }
                    self.output.goBack()
                }
            }
            Spacer()
        }
        .background(ColorManager.backgroundColour)
    }
}

#Preview {
    CreateOrEditCategoryView(viewModel: CreateOrEditCategoryViewModel(
        category: Category(),
        useCase: CategoryUseCaseImpl(
            service: CategoryServiceImpl()
        ),
        logoutService: LogoutService()
    ),
    output: CreateOrEditCategoryView.Output(goBack: {}, logout: {}))
}
