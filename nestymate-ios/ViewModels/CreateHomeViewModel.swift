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
    @Published public var name: String?
    @Published public var description: String?
    @Published public var address: String?
    @Published public var shouldShow: Bool?

    public func createHome(
        name: String?,
        description: String?,
        address: String?,
        completionHandler: @escaping () -> Void
    ) {
        guard let name, let description, let address else { return }
        shouldShow = true
        useCase.createHome(name: name, description: description, address: address) { [weak self] in
            self?.shouldShow = false
            completionHandler()
        }
    }
}
