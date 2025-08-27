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
                    let index = offset[offset.startIndex]
                    Task {
                        let response = try await viewModel.delete(categoryToBeDelete: categories[index])
                        handleCategories(response?.categories, response?.shouldLogout ?? false)
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
        .onAppear {
            Task {
                let response = try await viewModel.getCategories()
                handleCategories(response?.categories, response?.shouldLogout ?? false)
            }
        }
    }
}

private extension CategoriesView {
    func handleCategories(_ categories: [Category]?, _ shouldLogout: Bool) {
        guard !shouldLogout else { return output.logout() }
        self.categories = categories ?? []
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
