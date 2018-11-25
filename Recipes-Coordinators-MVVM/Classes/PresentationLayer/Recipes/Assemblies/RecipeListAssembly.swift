//
//  RecipeListAssembly.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 11/25/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

struct RecipeListAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(RecipeListViewModel.self,
                               argument: RecipeListViewModelArgument.self,
                               initializer: DefaultRecipeListViewModel.init)
    }
}
