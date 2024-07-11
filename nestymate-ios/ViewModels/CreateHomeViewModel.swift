//
//  CreateHomeViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Foundation
import SwiftUI

class CreateHomeViewModel: ObservableObject {
    let useCase: CreateHomeUseCase = CreateHomeUseCaseImpl()
    @Published public var name: FieldModel = .init(value: "", fieldType: .name)
    @Published public var description: FieldModel = .init(value: "", fieldType: .description)
    @Published public var address: FieldModel = .init(value: "", fieldType: .address)
    @Published public var shouldShowLoader: Bool?

    public func createHome(completionHandler: @escaping () -> Void) {
        if useCase.createValid(
            isNameValid: name.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAddressValid: address.onValidate()
        ) {
            shouldShowLoader = true
            useCase.createHome(name: name.value,
                               description: description.value,
                               address: address.value)
            { [weak self] in
                self?.shouldShowLoader = false
                completionHandler()
            }
        }
    }
}
