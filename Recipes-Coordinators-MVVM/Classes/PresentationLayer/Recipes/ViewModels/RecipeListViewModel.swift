//
//  RecipeListViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa
import Swinject

struct RecipeListViewModelInput {
    let selectRecipeTrigger: Signal<Int>
}

struct RecipeListViewModelOutput {
    let selectedRecipe: Signal<IdentifiableViewModel>
    let recipes: Driver<[IdentifiableViewModel]>
}

protocol RecipeListViewModel: ViewModel {

    var isRecipeSelected: Signal<Recipe> { get }
    func transform(input: RecipeListViewModelInput) -> RecipeListViewModelOutput
}
