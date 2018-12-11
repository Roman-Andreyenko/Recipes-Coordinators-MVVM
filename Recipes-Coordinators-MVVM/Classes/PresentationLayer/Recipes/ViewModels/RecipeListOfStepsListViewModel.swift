//
//  RecipeListOfStepsViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/6/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa
import Swinject

struct RecipeListOfStepsListViewModelInput {
}

struct RecipeListOfStepsListViewModelOutput {
}

protocol RecipeListOfStepsListViewModel: ViewModel {

    func transform(input: RecipeListOfStepsListViewModelInput) -> RecipeListOfStepsListViewModelOutput
}
