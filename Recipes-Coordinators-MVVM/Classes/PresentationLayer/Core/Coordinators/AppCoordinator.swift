//
//  AppCoordinator.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa
import Swinject

class AppCoordinator: BaseCoordinator<Void> {

    private let assembler: Assembler

    override init() {
        self.assembler = Assembler([UIKitAssembly(), NetworkAssembly()])
        super.init()
    }

    override func start() -> Signal<Void> {
        let recipeListCoordinator = RecipeListCoordinator(parentAssembler: assembler)
        return coordinate(to: recipeListCoordinator)
    }
}
