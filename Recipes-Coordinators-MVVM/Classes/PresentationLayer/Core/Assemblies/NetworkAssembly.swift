//
//  NetworkAssembly.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 11/25/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Swinject

struct NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container
            .register(NetworkReachabilityService.self) { _ in
                return DefaultNetworkReachabilityService()
            }
            .inObjectScope(.container)
    }
}
