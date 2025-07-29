//
//  MyHomeViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import Foundation

struct Menu: Hashable {
    let name: String
    let id: Int
}

final class MyHomeViewModel: ObservableObject {
    let homeUseCase: HomeUseCase
    let categoryUseCase: CategoryUseCase
    let title = String(localized: "my_home")
    let categories = [Menu(name: String(localized: "about"), id: 0),
                      Menu(name: String(localized: "categories"), id: 1)]

    init(homeUseCase: HomeUseCase, categoryUseCase: CategoryUseCase) {
        self.homeUseCase = homeUseCase
        self.categoryUseCase = categoryUseCase
    }
}
