//
//  MyHomeView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import SwiftUI

struct MyHomeView: View {
    @ObservedObject var viewModel: MyHomeViewModel = .init()
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
                    useCase: HomeUseCaseImpl(
                        homeService: HomeServiceImpl()),
                        isEdit: true
                )
                CreateOrEditHomeView(
                    viewModel: viewModel,
                    output: CreateOrEditHomeView.Output(
                        goToMainScreen: { output.goBack() },
                        logout: { output.logout() }
                    ))
            } else {
                CategoriesView(output: CategoriesView.Output(createCategory: {
                    output.createCategory()
                }))
            }
        }
        .background(ColorManager.backgroundColour)
        .hiddenNavigationBarStyle()
    }
}

#Preview {
    MyHomeView(output: MyHomeView.Output(goBack: {}, createCategory: {}, logout: {}))
}
