//
//  HomeService.swift
//  nestymate-ios
//
//  Created by Selini Kyriazidou on 19/5/24.
//

import Combine
import Foundation

protocol HomeService {
    func createHome(name: String, description: String, address: String, completionHandler: @escaping () -> Void)
    func getHome(completionHandler: @escaping (Home?) -> Void)
}

class HomeServiceImpl: HomeService {
    let url = URL(string: "http://192.168.1.10/api/v1/home")!
    var cancellable = Set<AnyCancellable>()
    let helper = KeychainHelper()
    func getHome(completionHandler: @escaping (Home?) -> Void) {
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        let token: String = helper.read() ?? ""
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                let statusCode = response.statusCode
                if (200 ... 299).contains(statusCode) {
                    return element.data
                }

                if statusCode == 400 {
                    return Data()
                }

                throw URLError(.badServerResponse)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(
                receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Completed getHome")
                    case let .failure(error):
                        print("Receiver error getHome \(error)")
                    }
                },
                // receive the data
                receiveValue: { data in
                    guard let response = try? JSONDecoder().decode(Home.self, from: data) else {
                        return completionHandler(nil)
                    }
                    completionHandler(response)
                }
            )
            .store(in: &cancellable)
    }

    func createHome(
        name: String,
        description: String,
        address: String,
        completionHandler: @escaping () -> Void
    ) {
        let data = try? JSONEncoder().encode(Home(name: name, description: description, address: address))
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        request.httpMethod = "POST"
        request.httpBody = data
        let token: String = helper.read() ?? ""
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
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
                        print("Completed createHome")
                    case let .failure(error):
                        print("Receiver error createHome \(error)")
                    }
                },
                // receive the data
                receiveValue: { data in
                    guard let response = try? JSONDecoder().decode(HomeResponse.self, from: data) else {
                        fatalError("Failed to decode \(data) from bundle.")
                    }
                    print(response)
                    completionHandler()
                }
            )
            .store(in: &cancellable)
    }
}
