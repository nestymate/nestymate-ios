//
//  Logger.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 29/8/25.
//

import Foundation

func logResponse(data: Data?, response: URLResponse?, url: String, method: String) {
    if let httpResponse = response as? HTTPURLResponse {
        print("🌐 Call :", "\(method) \(url) \(httpResponse.statusCode)")
        print("📋 Headers:", httpResponse.allHeaderFields)
    }
    guard let data else { return print("⚠️ No data received") }
    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
       let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
       let prettyString = String(data: jsonData, encoding: .utf8)
    {
        print("📦 Body:\n\(prettyString)")
    } else if let string = String(data: data, encoding: .utf8) {
        print("📜 Body:\n\(string)")
    }
}
