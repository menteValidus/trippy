//
//  ControllersAssembly.swift
//  Trippy
//
//  Created by Denis Cherniy on 08.08.2021.
//

import RouteController
import Swinject
import Repository

final class ControllersAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(IRouteController.self) { resolver in
            let routeRepository = resolver.resolve(IRouteRepository.self)!
            
            return RouteController(routeRepository: routeRepository)
        }
    }
}
