//
//  RecipeStepListViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 1/3/19.
//  Copyright © 2019 Roman Andreyenko. All rights reserved.
//

import RxCocoa
import Swinject

struct RecipeStepListViewModelInput {
}

struct RecipeStepListViewModelOutput {
    let steps: Driver<[IdentifiableViewModel]>
    let recipeName: Driver<String> //FIXME: Should be removed
}

protocol RecipeStepListViewModel: ViewModel, Identifiable {

    func transform(input: RecipeStepListViewModelInput) -> RecipeStepListViewModelOutput
}

extension RecipeStepListViewModel {
    static var identifier: String {
        return String(describing: type(of: RecipeStepListViewModel.self))
    }
}
