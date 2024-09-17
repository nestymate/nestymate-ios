//
//  MainScreenViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation

class MainScreenViewModel {
    let useCase: MainScreenUseCase
    init(useCase: MainScreenUseCase) {
        self.useCase = useCase
    }
}
