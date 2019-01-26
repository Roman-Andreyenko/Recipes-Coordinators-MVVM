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
    let didBack: Signal<Void>
}

struct RecipeListOfStepsListViewModelOutput {
    let recipes: Driver<[IdentifiableViewModel]>
}

protocol RecipeListOfStepsListViewModel: ViewModel {

    var didBack: Signal<Void> { get }
    func transform(input: RecipeListOfStepsListViewModelInput) -> RecipeListOfStepsListViewModelOutput
}
