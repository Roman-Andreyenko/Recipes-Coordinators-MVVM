//
//  UITableViewCellViwModelAssembly.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 11/25/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import RxCocoa

struct RecipeTextUnderPictureCellViewModelArgument {
    let recipe: Driver<Recipe>
    let isCheckerSelected: Bool
    let isCheckerHidden: Bool
}

struct TextUnderPictureCellViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(TextUnderPictureCellViewModel.self,
                               argument: RecipeTextUnderPictureCellViewModelArgument.self,
                               initializer: RecipeTextUnderPictureCellViewModel.init)
    }
}
