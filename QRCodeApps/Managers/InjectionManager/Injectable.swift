//
//  Injectable.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

@propertyWrapper
struct Injectable<T> {

    var injectable: T

    init(_ type: InjectableType = .automatic) {
        guard let injectable = InjectableManager.resolve(type, T.self) else {
            let dependencyName = String(describing: Injectable.self)
            fatalError("No dependency of type \(dependencyName) registered!")
        }

        self.injectable = injectable
    }

    var wrappedValue: T {
        get { self.injectable }
        mutating set { injectable = newValue }
    }
}
