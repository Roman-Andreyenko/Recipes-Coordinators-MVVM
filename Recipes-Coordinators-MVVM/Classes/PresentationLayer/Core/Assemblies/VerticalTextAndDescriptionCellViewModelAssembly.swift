//
//  VerticalTextAndDescriptionCellViewModelAssembly.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 11/25/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import RxCocoa

struct VerticalTextAndDescriptionCellViewModelArgument {
    let recipeEvent: Driver<Recipe>
}

struct VerticalTextAndDescriptionCellViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(VerticalTextAndDescriptionCellViewModel.self,
                               argument: VerticalTextAndDescriptionCellViewModelArgument.self,
                               initializer: RecipeVerticalTextAndDescriptionCellViewModel.init)
    }
}
