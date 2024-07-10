//
//  LoginService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 30/4/24.
//

import Combine
import Foundation

protocol LoginService {
    func login(username: String, password: String, completionHandler: @escaping () -> Void)
}

class LoginServiceImpl: LoginService {
    let mainUrl = URL(string: "http://192.168.1.10/auth")!
    var cancellable = Set<AnyCancellable>()
    func login(username: String, password: String, completionHandler: @escaping () -> Void) {
        let url: URL = mainUrl.appending(path: "login")
        let data = try? JSONEncoder().encode(Login(username: username, password: password)) // "test123" "test321"
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        request.httpMethod = "POST"
        request.httpBody = data
        let session = URLSession.shared
        session.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200 ... 299).contains(response.statusCode)
                else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(
                receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Completed")
                    case let .failure(error):
                        print("Receiver error \(error)")
                    }
                },
                // receive the data
                receiveValue: { data in
                    guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                        fatalError("Failed to decode \(data) from bundle.")
                    }
                    print(response.token)
                    let helper = KeychainHelper()
                    helper.save(Data(response.token.utf8))
                    completionHandler()
                }
            )
            .store(in: &cancellable)
    }
}
