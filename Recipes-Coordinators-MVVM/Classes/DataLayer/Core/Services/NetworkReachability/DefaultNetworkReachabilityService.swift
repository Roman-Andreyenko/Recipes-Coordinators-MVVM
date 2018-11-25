//
//  DefaultNetworkReachabilityService.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 11/18/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Reachability

final class DefaultNetworkReachabilityService: NetworkReachabilityService {

    private let reachability: Reachability
    private lazy var listeners: [UUID: Listener] = [:]

    init() {
        reachability = Reachability()!
        reachability.whenReachable = { [weak self] reachability in
            self?.sendStatus(from: reachability)
        }
        reachability.whenUnreachable = { [weak self] reachability in
            self?.sendStatus(from: reachability)
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    deinit {
        reachability.stopNotifier()
    }

    func register(listener: @escaping Listener) -> UUID {
        let uuid = UUID()
        listeners[uuid] = listener
        return uuid
    }

    func unregister(listenerWithUUID uuid: UUID) {
        listeners[uuid] = nil
    }

    private func sendStatus(from reachability: Reachability) {
        let status = self.getStatus(from: reachability.connection)
        self.listeners.values.forEach { listener in
            listener(status)
        }
    }

    private func getStatus(from status: Reachability.Connection) -> NetworkReachabilityConnection {
        switch status {
        case .cellular:
            return .cellular
        case .wifi:
            return .wifi
        case .none:
            return .none
        }
    }
}
