//
//  Error.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 17/7/24.
//

import Foundation
import SwiftUI

enum Error: Identifiable {
    var id: Self { return self }

    case noNetwork
    case badServerResponse

    var alert: Alert {
        switch self {
        case .noNetwork:
            Alert(title: Text("No internet connection"))
        case .badServerResponse:
            Alert(title: Text("An error occurred, please try again"))
        }
    }
}
