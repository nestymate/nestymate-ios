//
//  MyHomeView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import SwiftUI

struct MyHomeView: View {
    @ObservedObject var viewModel: MyHomeViewModel
    @State private var tab = 0
    struct Output {
        var goBack: () -> Void
        var createCategory: () -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            Picker("", selection: $tab) {
                ForEach(viewModel.categories, id: \.self) {
                    Text($0.name).tag($0.id)
                }
            }
            .padding()
            .pickerStyle(.segmented)
            .colorMultiply(ColorManager.buttonBackgroundColour)
            .onAppear {
                UISegmentedControl.appearance().tintColor = ColorManager.backgroundColourUIKit
            }
            
            if tab == 0 {
                let viewModel = CreateOrEditHomeViewModel(
                    useCase: viewModel.homeUseCase ,
                    isEdit: true
                )
                CreateOrEditHomeView(
                    viewModel: viewModel,
                    output: CreateOrEditHomeView.Output(
                        goToMainScreen: { output.goBack() },
                        logout: { output.logout() }
                    )
                )
            } else {
                CategoriesView(
                    viewModel: CategoryViewModel(useCase: viewModel.categoryUseCase),
                    output: CategoriesView.Output(createCategory: {
                    output.createCategory()
                }))
            }
        }
        .background(ColorManager.backgroundColour)
        .hiddenNavigationBarStyle()
    }
}

#Preview {
    MyHomeView(viewModel: MyHomeViewModel(
        homeUseCase: HomeUseCaseImpl(homeService: HomeServiceImpl()),
        categoryUseCase: CategoryUseCaseImpl()),
               output: MyHomeView.Output(goBack: {}, createCategory: {}, logout: {}))
}
