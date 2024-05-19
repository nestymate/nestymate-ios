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

    public func createHome(
        name: String?,
        description: String?,
        address: String?,
        completionHandler: @escaping () -> Void
    ) {
        guard let name, let description, let address else { return }
        useCase.createHome(name: name, description: description, address: address, completionHandler: completionHandler)
    }
}
