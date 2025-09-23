//
//  Category.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 15/9/24.
//

import Foundation

public struct Category: Identifiable, Decodable, Encodable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let description: String?

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description)
    }

    init(id: Int, name: String, description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }

    init() {
        id = 0
        name = ""
        description = ""
    }
}
