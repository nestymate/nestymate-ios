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
                Task {
                    let shouldLogout = try await viewModel.createOrUpdateCategory()
                    if !shouldLogout {
                        output.goBack()
                    } else {
                        output.logout()
                    }
                }
            }
            Spacer()
        }
        .background(ColorManager.backgroundColour)
        .onAppear {
            Task {
                let shouldLogout = try await viewModel.getCategory()
                if shouldLogout {
                    output.logout()
                }
            }
        }
    }
}

#Preview {
    CreateOrEditCategoryView(viewModel: CreateOrEditCategoryViewModel(
        categoryId: 1,
        useCase: CategoryUseCaseImpl(
            service: CategoryServiceImpl()
        ), homeUseCase: HomeUseCaseImpl(homeService: HomeServiceImpl()),
        logoutService: LogoutService()
    ),
    output: CreateOrEditCategoryView.Output(goBack: {}, logout: {}))
}
