//
//  DefaultRecipeStepListViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 1/3/19.
//  Copyright © 2019 Roman Andreyenko. All rights reserved.
//

import RxCocoa
import RxSwift
import Swinject

final class DefaultRecipeStepListViewModel: RecipeStepListViewModel {

    private let resolver: Resolver
    private let disposeBag = DisposeBag()
    private let recipe: Recipe

    init(argument: DefaultRecipeStepListViewModelArgument) {
        self.resolver = argument.resolver
        self.recipe = argument.recipe
    }

    func transform(input: RecipeStepListViewModelInput) -> RecipeStepListViewModelOutput {
        let cellViewModels = [IdentifiableViewModel]()
        let recipesModels = Driver.of(cellViewModels)
        let recipeName = Driver.of(recipe.name)
        return RecipeStepListViewModelOutput (steps: recipesModels, recipeName: recipeName)
    }
}
