//
//  RecipeStepListAssembly.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 1/3/19.
//  Copyright © 2019 Roman Andreyenko. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

struct DefaultRecipeStepListViewModelArgument {
    let resolver: Resolver
    let recipe: Recipe
}

struct RecipeStepListAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(RecipeStepListViewModel.self,
                               argument: DefaultRecipeStepListViewModelArgument.self,
                               initializer: DefaultRecipeStepListViewModel.init)
    }
}
