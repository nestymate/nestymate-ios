//
//  CategoriesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoryViewModel
    @State private var viewDidLoad = false
    @State private var categories: [Category] = []
    struct Output {
        var createCategory: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Categories").font(FontManager.title)
                Spacer()
                Button {
                    self.output.createCategory()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding()

            List {
                ForEach(categories) { item in
                    Text(item.name)
                }
                .onDelete(perform: viewModel.delete)
            }
            .padding()
        }
        .background(ColorManager.backgroundColour)
        .onAppear {
            if viewDidLoad == false {
                viewDidLoad = true
                viewModel.getCategories { categories in
                    self.categories = categories
                }
            }
        }
    }
}

#Preview {
    CategoriesView(viewModel: CategoryViewModel(useCase: CategoryUseCaseImpl()), 
                   output: CategoriesView.Output(createCategory: {}))
}
