//
//  EditHomeViewModel.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/9/24.
//

import Foundation
import SwiftUI

class EditHomeViewModel: ObservableObject {
    let useCase: MyHomeUseCase = MyHomeUseCaseImpl(homeService: HomeServiceImpl())
    @Published public var name: FieldModel = .init(value: "", fieldType: .name)
    @Published public var description: FieldModel = .init(value: "", fieldType: .description)
    @Published public var address: FieldModel = .init(value: "", fieldType: .address)
    @Published public var shouldShowLoader: Bool?
    @Published var error: Error?
    private var home: Home?
    public func getHome() {
        shouldShowLoader = true
        useCase.getHome { [weak self] home, error in
            guard let self else { return }
            self.shouldShowLoader = false
            self.error = error
            guard let home else { return }
            self.home = home
            self.name = .init(value: home.name, fieldType: .name)
            self.description = .init(value: home.description, fieldType: .description)
            self.address = .init(value: home.address, fieldType: .address)
        }
    }

    public func editHome(completionHandler: @escaping () -> Void) {
        if useCase.createValid(
            isNameValid: name.onValidate(),
            isDescriptionValid: description.onValidate(),
            isAddressValid: address.onValidate()
        ) {
            shouldShowLoader = true
            guard let originalHome = home else { return }
            let home = Home(
                reference: originalHome.reference,
                name: name.value,
                description: description.value,
                address: address.value
            )
            useCase.editHome(home: home) { [weak self] error in
                self?.shouldShowLoader = false
                self?.error = error
                completionHandler()
            }
        }
    }
}
