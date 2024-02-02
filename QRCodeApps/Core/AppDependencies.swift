//
//  AppDependencies.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

class AppDependencies {
    
    static let shared = AppDependencies()
    
    func getDependencies() {
        InjectableManager.register(type: APIClient.self, APIClientManager())
        
        //Repositories goes here...
        InjectableManager.register(type: HomeRepositoryProtocol.self, HomeRepository())
        
        //Router for module goes here...
        InjectableManager.register(type: HomeModuleProtocol.self, HomeModule())
        InjectableManager.register(type: QRCodeModuleProtocol.self, QRCodeModule())
    }
}
