//
//  ServiceLocator.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 12/08/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

// MARK: - ServiceLocation Protocol

protocol ServiceLocation {
    func getService<T>() -> T?
}

// MARK: - ServiceLocator implementation

class ServiceLocator: ServiceLocation {
    
    // MARK: - Properties
    
    private lazy var services: Dictionary<String, Any> = [:]
    
    // MARK: - Singletone instanse
    
    public static let shared = ServiceLocator()
    private init() {}
    
    // MARK: - Core behavior
    
    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
    
    func addService<T>(_ service: T) {
        let key = typeName(some: service)
        services[key] = service
    }
    
    // MARK: - Helper functions
    
    private func typeName(some: Any) -> String {
        return some is Any.Type ? "\(some.self)" : "\(type(of: some))"
    }
    
    static func setupServices() {
        ServiceLocator.shared.addService(DiagramImageProvider())
        ServiceLocator.shared.addService(AlgoProvider())
        ServiceLocator.shared.addService(FeedDataProvider())
        ServiceLocator.shared.addService(JsonPlaceholderProvider())
    }
}
