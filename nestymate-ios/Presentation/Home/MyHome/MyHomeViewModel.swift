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

class MyHomeViewModel: ObservableObject {
    let homeUseCase:HomeUseCase
    let categoryUseCase:CategoryUseCase
    let categories = [Menu(name: "My Home", id: 0), Menu(name: "Categories", id: 1)]
    
    init(homeUseCase: HomeUseCase, categoryUseCase: CategoryUseCase) {
        self.homeUseCase = homeUseCase
        self.categoryUseCase = categoryUseCase
    }
}
