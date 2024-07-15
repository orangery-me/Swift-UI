//
//  ImageWebRepository.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 13/07/2024.
//

import Combine
import Foundation
import UIKit

protocol ImageWebRepository: WebRepository {
    func load(imageURL: URL) -> AnyPublisher<UIImage, Error>
}

struct RealImageWebRepository: ImageWebRepository {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func load(imageURL: URL) -> AnyPublisher<UIImage, Error> {
        return download(rawImageURL: imageURL)
            .subscribe(on: bgQueue)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func download(rawImageURL: URL) -> AnyPublisher<UIImage, Error> {
        let urlRequest = URLRequest(url: rawImageURL)
        return session.dataTaskPublisher(for: urlRequest)
            .requestData()
            .tryMap { data -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw APIError.imageDeserialization
                }
                return image
            }
            .eraseToAnyPublisher()
    }
}
