//
//  CancelBag.swift
//  SwiftUIApp
//
//  Created by Chau Thi on 13/07/2024.
//

import Combine

final class CancelBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    private let equalToAny: Bool

    init(equalToAny: Bool = false) {
        self.equalToAny = equalToAny
    }

    func cancel() {
        subscriptions.removeAll()
    }

    func isEqual(to other: CancelBag) -> Bool {
        return other === self || other.equalToAny || equalToAny
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
