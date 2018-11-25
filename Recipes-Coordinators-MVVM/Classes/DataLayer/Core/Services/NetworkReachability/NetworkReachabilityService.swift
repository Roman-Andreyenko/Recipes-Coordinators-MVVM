//
//  NetworkReachabilityService.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 11/18/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Foundation

enum NetworkReachabilityConnection {
    case none, wifi, cellular
}

protocol NetworkReachabilityService {
    typealias Listener = ((NetworkReachabilityConnection) -> ())

    func register(listener: @escaping Listener) -> UUID
    func unregister(listenerWithUUID uuid: UUID)
}
