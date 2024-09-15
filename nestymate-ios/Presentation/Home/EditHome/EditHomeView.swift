//
//  EditHomeView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import SwiftUI

struct EditHomeView: View {
    @ObservedObject var viewModel: EditHomeViewModel = .init()
    struct Output {
        var goBack: () -> Void
    }

    var output: Output
    @State private var viewDidLoad = false
    var body: some View {
        VStack {
            Text("Edit Home").font(FontManager.title)
            SingleTextField(fieldModel: $viewModel.name)
                .onSubmit {
                    _ = viewModel.name.onSubmitError()
                }
            SingleTextField(fieldModel: $viewModel.description)
                .onSubmit {
                    _ = viewModel.description.onSubmitError()
                }
            SingleTextField(fieldModel: $viewModel.address)
                .onSubmit {
                    _ = viewModel.address.onSubmitError()
                }
            ActionButton(title: "Update", shouldEnableButton: true) {
                viewModel.editHome {
                    self.output.goBack()
                }
            }
            Spacer()
        }
        .onAppear {
            if viewDidLoad == false {
                viewDidLoad = true
                viewModel.getHome()
            }
        }
        .background(ColorManager.backgroundColour)
    }
}

#Preview {
    EditHomeView(output: EditHomeView.Output(goBack: {}))
}
