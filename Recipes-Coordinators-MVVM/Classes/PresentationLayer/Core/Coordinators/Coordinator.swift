//
//  Coordinator.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/18/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

/// Coordinator generic over the return type of the `start` method.
protocol Coordinator {

    /// Assosiated type which allows to access a ResultType of the Coordainator by `CoordinatorName.CoordinationResult`.
    associatedtype CoordinationResult

    /// - Parameter coordinator: Coordinator to start.
    /// - Returns: Result of coordinator's work.
    func coordinate(to: Self) -> Signal<CoordinationResult>

    /// Starts job of the coordinator.
    ///
    /// - Returns: Result of coordinator's work.
    func start() -> Signal<CoordinationResult>
}
