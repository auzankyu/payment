//
//  InjectionManager.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

enum InjectableType {
    case singleton
    case newSingleton
    case new
    case automatic
}

class InjectableManager {
    
    private static var factories: [String: () -> Any] = [:]
    private static var cache: [String: Any] = [:]
    
    // Register Class yang ingin di inject
    static func register<T>(type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        factories[String(describing: type.self)] = factory
    }


    static func resolve<T>(_ resolveType: InjectableType = .automatic, _ type: T.Type) -> T? {
        let injectableName = String(describing: type.self)

        switch resolveType {
        case .singleton:
            if let injectable = cache[injectableName] as? T {
                print("cached: \(injectable)")
                return injectable
            } else {
                let injectable = factories[injectableName]?() as? T

                if let injectable = injectable {
                    cache[injectableName] = injectable
                }
                return injectable
            }
        case .newSingleton:
            let injectable = factories[injectableName]?() as? T

            if let injectable = injectable {
                cache[injectableName] = injectable
            }

            return injectable
        case .automatic:
            fallthrough
        case .new:
            return factories[injectableName]?() as? T
        }
    }

}
