//
//  RepositoriesAssembly.swift
//  Trippy
//
//  Created by Denis Cherniy on 05.08.2021.
//

import Swinject
import Repository

final class RepositoriesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(IRouteRepository.self) { _ in
            InMemoryRouteRepository()
        }
    }
}
