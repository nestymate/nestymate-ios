//
//  HomeUserDefaults.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 8/10/24.
//

import Foundation

final class HomeUserDefaults: Sendable {
    private let homeKey = "homeId"

    func saveHome(with id: Int?) {
        guard let id else { return }
        UserDefaults.standard.set(id, forKey: homeKey)
    }

    func getHomeId() -> String {
        "\(UserDefaults.standard.integer(forKey: homeKey))"
    }

    func deleteHome() {
        UserDefaults.standard.removeObject(forKey: homeKey)
    }
}
