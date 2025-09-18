//
//  CategoriesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    struct Output {
        var goToCreateCategory: () -> Void
        var goToEditCategory: (Category?) -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(String(localized: "categories")).font(FontManager.title)
                Spacer()
                Button {
                    output.goToCreateCategory()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding()

            List {
                ForEach(viewModel.categories) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(ColorManager.backgroundList)
                    .cornerRadius(12)
                    .onTapGesture {
                        output.goToEditCategory(item)
                    }
                }
                .onDelete(perform: { offset in
                    Task {
                        try await viewModel.delete(at: offset)
                    }
                })
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 2)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .padding()
        }
        .background(ColorManager.backgroundColour)
        .alert(item: $viewModel.error) { error in
            handleHttpErrorAlert(error: error) {
                output.logout()
            }
        }
        .onAppear {
            Task {
                try await viewModel.getCategories()
            }
        }
    }
}

#Preview {
    CategoriesView(viewModel: CategoriesViewModel(
        useCase: CategoryUseCaseImpl(service: CategoryServiceMock()),
        homeUseCase: HomeUseCaseImpl(homeService: HomeServiceImpl()),
        logoutService: LogoutService()
    ),
    output: CategoriesView.Output(
        goToCreateCategory: {},
        goToEditCategory: { _ in },
        logout: {}
    ))
}
