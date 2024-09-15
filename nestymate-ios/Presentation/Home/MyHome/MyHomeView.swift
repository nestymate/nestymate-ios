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
    }

    var output: Output
    var body: some View {
        VStack {
            Picker("", selection: $tab) {
                ForEach(viewModel.categories, id: \.self) {
                    Text($0.name).tag($0.id)
                }
            }
            .pickerStyle(.segmented)
            .colorMultiply(ColorManager.buttonBackgroundColour)
            .onAppear {
                UISegmentedControl.appearance().tintColor = ColorManager.backgroundColourUIKit
            }
            if tab == 0 {
                EditHomeView(output: EditHomeView.Output(goBack: {
                    output.goBack()
                }))
            } else {
                CategoriesView()
            }
        }
        .background(ColorManager.backgroundColour)
    }
}

#Preview {
    MyHomeView(output: MyHomeView.Output(goBack: {}))
}
