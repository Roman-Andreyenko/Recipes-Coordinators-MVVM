//
//  UIKitAssembly.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/1/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Swinject

struct UIKitAssembly: Assembly {

    func assemble(container: Container) {
        container
            .register(UIWindow.self, name: DependencyNames.UIKit.rootWindow.rawValue) { _ in
                return UIWindow()
            }
            .inObjectScope(.container)
    }
}
