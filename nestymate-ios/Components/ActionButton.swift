//
//  ActionButton.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 23/4/24.
//

import SwiftUI

struct ActionButton: View {
    var title: String = ""
    let customAction: () -> Void
    var body: some View {
        Button {
            customAction()
        } label: {
            Text(title)
                .font(FontManager.button)
                .foregroundStyle(ColorManager.buttonTextColour)
                .frame(maxWidth: .infinity)
                .padding(PaddingManager.xsmallPadding)
        }
        .buttonStyle(.bordered)
        .background(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
            .fill(ColorManager.buttonBackgroundColour)
        )
        .padding()
    }
}

#Preview {
    ActionButton(title: "test", customAction: {})
}
