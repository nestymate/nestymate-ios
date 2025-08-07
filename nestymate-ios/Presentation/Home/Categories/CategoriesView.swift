//
//  CategoriesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    @State private var categories: [Category] = []
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
                ForEach(categories) { item in
                    Text(item.name)
                        .onTapGesture {
                            output.goToEditCategory(item)
                        }
                }
                .onDelete(perform: { offset in
                    let index = offset[offset.startIndex]
                    Task {
                        let response = try await viewModel.delete(categoryToBeDelete: categories[index])
                        handleExpenses(response?.categories, response?.shouldLogout ?? false)
                    }
                })
                .listRowBackground(ColorManager.backgroundColour)
            }
            .scrollContentBackground(.hidden)
            .padding()
        }
        .background(ColorManager.backgroundColour)
        .onAppear {
            Task {
                let response = try await viewModel.getCategories()
                handleExpenses(response?.categories, response?.shouldLogout ?? false)
            }
        }
    }
}

private extension CategoriesView {
    func handleExpenses(_ categories: [Category]?, _ shouldLogout: Bool) {
        guard !shouldLogout else { return output.logout() }
        self.categories = categories ?? []
    }
}

#Preview {
    CategoriesView(viewModel: CategoriesViewModel(
        useCase: CategoryUseCaseImpl(service: CategoryServiceImpl()),
        homeUseCase: HomeUseCaseImpl(homeService: HomeServiceImpl()),
        logoutService: LogoutService()
    ),
    output: CategoriesView.Output(
        goToCreateCategory: {},
        goToEditCategory: { _ in },
        logout: {}
    ))
}
