//
//  DependencyInjector.swift
//  Trippy
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Swinject

final class DependencyInjector {
    
    static let shared = DependencyInjector()
    
    private let assembler = Assembler([RepositoriesAssembly()])
    
    private init() { }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        assembler.resolver.resolve(serviceType)
    }
}
