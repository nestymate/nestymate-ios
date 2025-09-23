//
//  Logger.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 29/8/25.
//

import Foundation

func logResponse(data: Data?, response: URLResponse?, url: String, method: String, requestData: Data?) {
    if let httpResponse = response as? HTTPURLResponse {
        print("🌐 Call :", "\(method) \(url) \(httpResponse.statusCode)")
        print("📋 Headers:", httpResponse.allHeaderFields)
        print("ℹ️ RequestData:\n\(showPretty(data: requestData ?? Data()))")
    }
    guard let data else { return print("⚠️ No data received") }
    print("📦 Body:\n\(showPretty(data: data))")
}

private func showPretty(data: Data) -> String {
    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
       let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
       let prettyString = String(data: jsonData, encoding: .utf8)
    {
        return prettyString
    } else if let string = String(data: data, encoding: .utf8) {
        return string
    }
    return "-"
}
