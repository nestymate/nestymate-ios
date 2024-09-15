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
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: ColorManager.mainColor))
                    .scaleEffect(2.0, anchor: .center)
                    .isHidden(!isShowing)
            }
        }
    }
}
