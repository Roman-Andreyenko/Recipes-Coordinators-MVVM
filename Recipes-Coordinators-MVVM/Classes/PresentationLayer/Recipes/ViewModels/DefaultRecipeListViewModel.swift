//
//  RecipeListViewModelImp.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa
import RxSwift
import Swinject

final class DefaultRecipeListViewModel: RecipeListViewModel {

    private let recipes = [Recipe(name: "recipe1", description: "cullest recipe1", pictureUrl: nil, steps: nil),
                           Recipe(name: "recipe2", description: "cullest recipe2", pictureUrl: nil, steps: nil),
                           Recipe(name: "recipe3", description: "cullest recipe3", pictureUrl: nil, steps: nil),
                           Recipe(name: "recipe4", description: "cullest recipe4", pictureUrl: nil, steps: nil),
                           Recipe(name: "recipe5", description: "cullest recipe5", pictureUrl: nil, steps: nil)]
    private let resolver: Resolver
    private let disposeBag = DisposeBag()

    init(argument: DefaultRecipeListViewModelArgument) {
        self.resolver = argument.resolver
    }

    func transform(input: RecipeListViewModelInput) -> RecipeListViewModelOutput {
        var cellViewModels = [IdentifiableViewModel]()
        cellViewModels.reserveCapacity(recipes.count * 2)
        recipes.forEach {
            let pictureRecipeItem = resolver.resolve(
                TextUnderPictureCellViewModel.self,
                argument: RecipeTextUnderPictureCellViewModelArgument(
                    recipe: Driver.of($0),
                    isCheckerSelected: false,
                    isCheckerHidden: false
                )
            )!
            pictureRecipeItem
                .isCheckerSelected
                .asDriver()
                .skip(1)
                .drive(onNext: { isSelected in
                    print("item: \(isSelected)")
                })
                .disposed(by: disposeBag)
            cellViewModels.append(pictureRecipeItem)
            cellViewModels.append(
                resolver.resolve(
                    VerticalTextAndDescriptionCellViewModel.self,
                    argument: VerticalTextAndDescriptionCellViewModelArgument(
                        recipeEvent: Driver.of($0)
                    )
                )!
            )
        }
        let recipesModels = Driver.of(cellViewModels)
        let selectedRecipe = input.selectRecipeTrigger.withLatestFrom(recipesModels) { index, recipes in
            return recipes[index]
        }
        return RecipeListViewModelOutput(selectedRecipe: selectedRecipe, recipes: recipesModels)
    }
}

