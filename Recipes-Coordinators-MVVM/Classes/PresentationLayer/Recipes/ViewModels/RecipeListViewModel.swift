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
    let selectRecipeTrigger: Driver<Int>
}

struct RecipeListViewModelOutput {
    let selectedRecipe: Driver<IdentifiableViewModel>
    let recipes: Driver<[IdentifiableViewModel]>
}

protocol RecipeListViewModel: ViewModel {

    func transform(input: RecipeListViewModelInput) -> RecipeListViewModelOutput
}
