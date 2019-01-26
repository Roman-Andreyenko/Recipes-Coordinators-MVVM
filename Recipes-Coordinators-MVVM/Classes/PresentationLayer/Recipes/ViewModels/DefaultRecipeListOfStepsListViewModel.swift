//
//  DefaultRecipeListOfStepsListViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/22/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa
import RxSwift
import Swinject

final class DefaultRecipeListOfStepsListViewModel {

    let didBack: Signal<Void>
    private let _didBack: PublishRelay<Void>
    private let recipes = [Recipe(name: "recipe1", description: "cullest recipe1", pictureUrl: nil, steps: [RecipeStep(stepDescription: "step 1")]),
                           Recipe(name: "recipe2", description: "cullest recipe2", pictureUrl: nil, steps: [RecipeStep(stepDescription: "step 2")]),
                           Recipe(name: "recipe3", description: "cullest recipe3", pictureUrl: nil, steps: [RecipeStep(stepDescription: "step 3")]),
                           Recipe(name: "recipe4", description: "cullest recipe4", pictureUrl: nil, steps: [RecipeStep(stepDescription: "step 4")]),
                           Recipe(name: "recipe5", description: "cullest recipe5", pictureUrl: nil, steps: [RecipeStep(stepDescription: "step 5")])]
    private let resolver: Resolver
    private let disposeBag = DisposeBag()

    init(argument: DefaultRecipeListOfStepsListViewModelArgument) {
        self.resolver = argument.resolver
        self._didBack = PublishRelay()
        self.didBack = _didBack.asSignal()
    }
}

extension DefaultRecipeListOfStepsListViewModel: RecipeListOfStepsListViewModel {

    func transform(input: RecipeListOfStepsListViewModelInput) -> RecipeListOfStepsListViewModelOutput {
        input.didBack
            .emit(to: _didBack)
            .disposed(by: disposeBag)
        let cellViewModels: [IdentifiableViewModel] = recipes.enumerated().map {
            if $0 % 2 == 0 {
                return resolver.resolve(
                    RecipeStepListViewModel.self,
                    argument: DefaultRecipeStepListViewModelArgument(
                        resolver: resolver,
                        recipe: $1
                    )
                    )!
            } else {
                return resolver.resolve(
                    TextUnderPictureCellViewModel.self,
                    argument: RecipeTextUnderPictureCellViewModelArgument(
                        recipe: Driver.of($1),
                        isCheckerSelected: false,
                        isCheckerHidden: false
                    )
                    )!
            }
        }
        let recipesModels = Driver.of(cellViewModels)
        return RecipeListOfStepsListViewModelOutput(recipes: recipesModels)
    }
}
