//
//  ActivityIndicatorIView.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 10/7/24.
//

import SwiftUI

struct ActivityIndicatorIView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .center) {
                content()
                    .disabled(isShowing)
                    .blur(radius: isShowing ? 3 : 0)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: ColorManager.mainColor))
                    .scaleEffect(2.0, anchor: .center)
                    .isHidden(!isShowing)
            }
        }
    }
}
