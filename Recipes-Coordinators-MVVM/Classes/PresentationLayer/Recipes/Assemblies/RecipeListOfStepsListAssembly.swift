//
//  RecipeListOfStepsListAssembly.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/30/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

struct DefaultRecipeListOfStepsListViewModelArgument {
    let resolver: Resolver
}

struct RecipeListOfStepsListAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(RecipeListOfStepsListViewModel.self,
                               argument: DefaultRecipeListOfStepsListViewModelArgument.self,
                               initializer: DefaultRecipeListOfStepsListViewModel.init)
    }
}
