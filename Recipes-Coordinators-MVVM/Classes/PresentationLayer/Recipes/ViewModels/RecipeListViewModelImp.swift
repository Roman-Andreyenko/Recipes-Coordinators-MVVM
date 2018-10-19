//
//  RecipeListViewModelImp.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

final class RecipeListViewModelImp: RecipeListViewModel {

    private let recipes = [Recipe(name: "recipe1", description: "cullest recipe1", pictureUrl: nil, steps: nil),
                           Recipe(name: "recipe2", description: "cullest recipe2", pictureUrl: nil, steps: nil),
                           Recipe(name: "recipe3", description: "cullest recipe3", pictureUrl: nil, steps: nil),
                           Recipe(name: "recipe4", description: "cullest recipe4", pictureUrl: nil, steps: nil),
                           Recipe(name: "recipe5", description: "cullest recipe5", pictureUrl: nil, steps: nil)]

    func transform(input: RecipeListViewModelInput) -> RecipeListViewModelOutput {
        var cellViewModels = [CellViewModel]()
        cellViewModels.reserveCapacity(recipes.count * 2)
        recipes.forEach {
            cellViewModels.append(TextUnderPictureCellViewModelImp(recipe: $0))
            cellViewModels.append(VerticalTextAndDescriptionCellViewModelImp(recipe: $0))
        }
        let recipesModels = Driver.of(cellViewModels)
        let selectedRecipe = input.selectRecipeTrigger.withLatestFrom(recipesModels) { index, recipes in
            return recipes[index]
        }
        return RecipeListViewModelOutput(selectedRecipe: selectedRecipe, recipes: recipesModels)
    }
}

