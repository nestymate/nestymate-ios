//
//  HomesView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 18/9/25.
//

import SwiftUI

struct HomesView: View {
    @ObservedObject var viewModel: HomesViewModel
    @State private var homes: [Home] = []
    struct Output {
        var goToEditHome: (Home?) -> Void
        var logout: () -> Void
    }

    var output: Output
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(String(localized: "Homes")).font(FontManager.title)
            }
            .padding()

            List {
                ForEach(homes) { item in
                    HStack(spacing: .zero) {
                        Text(item.name)
                            .padding(.trailing, PaddingManager.xsmallPadding)
                        if item.active {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(ColorManager.activeColor)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(ColorManager.backgroundList)
                    .cornerRadius(12)
                    .onTapGesture {
                        output.goToEditHome(item)
                    }
                }
                .onDelete(perform: { offset in
                    let index = offset[offset.startIndex]
                    Task {
                        homes = try await viewModel.delete(homeToBeDelete: homes[index]) ?? []
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
                homes = try await viewModel.getHomes() ?? []
            }
        }
    }
}

#Preview {
    // HomesView()
}
