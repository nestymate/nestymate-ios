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
    let categories = [Menu(name: "My Home", id: 0), Menu(name: "Categories", id: 1)]
}
