//
//  AppCoordinator.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxSwift
import Swinject

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow
    private let assembler: Assembler

    override init() {
        self.window = UIWindow()
        self.assembler = Assembler([NetworkAssembly()])
        super.init()
    }

    override func start() -> Observable<Void> {
        let recipeListCoordinator = RecipeListCoordinator(parentAssembler: assembler, window: window)
        return coordinate(to: recipeListCoordinator)
    }
}
