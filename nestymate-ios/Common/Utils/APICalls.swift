//
//  APICalls.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 17/7/24.
//

import Combine
import Foundation

class APICalls {
    var cancellable = Set<AnyCancellable>()
    let helper = KeychainHelper()

    public init() {
        cancellable = Set<AnyCancellable>()
    }

    func post(
        url: URL,
        requestData: Data? = nil,
        authentication: Bool = true,
        completionHandler: @escaping (APIResponse) -> Void
    ) {
        genericCall(url, requestData, "POST", authentication) { apiResponse in
            completionHandler(apiResponse)
        }
    }

    func get(
        url: URL,
        requestData: Data?,
        authentication: Bool = true,
        completionHandler: @escaping (APIResponse) -> Void
    ) {
        genericCall(url, requestData, "GET", authentication) { apiResponse in
            completionHandler(apiResponse)
        }
    }

    func put(
        url: URL,
        requestData: Data? = nil,
        authentication: Bool = true,
        completionHandler: @escaping (APIResponse) -> Void
    ) {
        genericCall(url, requestData, "PUT", authentication) { apiResponse in
            completionHandler(apiResponse)
        }
    }

    func delete(
        url: URL,
        requestData: Data? = nil,
        authentication: Bool = true,
        completionHandler: @escaping (APIResponse) -> Void
    ) {
        genericCall(url, requestData, "DELETE", authentication) { apiResponse in
            completionHandler(apiResponse)
        }
    }

    private func genericCall(
        _ url: URL,
        _ requestData: Data? = nil,
        _ method: String,
        _ authentication: Bool,
        completionHandler: @escaping (APIResponse) -> Void
    ) {
        guard Reachability.isConnectedToNetwork() else {
            return completionHandler(APIResponse(nil, nil, .noNetwork))
        }
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        request.httpMethod = method
        request.httpBody = requestData
        let session = URLSession.shared
        if let token: String = helper.read(), authentication {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        session.dataTaskPublisher(for: request)
            .tryMap { element -> (APIResponse) in
                guard let response = element.response as? HTTPURLResponse
                else {
                    return APIResponse(element.data, 500, .badServerResponse)
                }
                return APIResponse(element.data, response.statusCode, nil)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(
                receiveCompletion: { status in
                    switch status {
                    case .finished: return
                    case let .failure(error):
                        print("Receiver error \(error)")
                    }
                },
                // receive the data
                receiveValue: { apiResponse in
                    print("----Api Call-----------", "\(method) \(url) \(apiResponse.statusCode ?? 0)")
                    completionHandler(apiResponse)
                }
            )
            .store(in: &cancellable)
    }
}
