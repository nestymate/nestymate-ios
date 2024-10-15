//
//  Category.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

public struct Category: Identifiable, Decodable, Encodable, Hashable {
    public let id: Int
    public let code: String
    public let name: String
    public let description: String

    init(id: Int, code: String, name: String, description: String) {
        self.id = id
        self.code = code
        self.name = name
        self.description = description
    }

    init() {
        id = 0
        code = ""
        name = ""
        description = ""
    }
}
