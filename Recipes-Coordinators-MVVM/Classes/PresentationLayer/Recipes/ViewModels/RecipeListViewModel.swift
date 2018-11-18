//
//  RecipeListViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

struct RecipeListViewModelInput {
    let selectRecipeTrigger: Driver<Int>
}

struct RecipeListViewModelOutput {
    let selectedRecipe: Driver<CellViewModel>
    let recipes: Driver<[CellViewModel]>
}

protocol RecipeListViewModel: ViewModel {

    func transform(input: RecipeListViewModelInput) -> RecipeListViewModelOutput
}