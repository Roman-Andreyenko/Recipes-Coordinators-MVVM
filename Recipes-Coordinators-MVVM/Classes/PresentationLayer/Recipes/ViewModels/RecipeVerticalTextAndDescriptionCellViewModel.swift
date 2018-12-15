//
//  VerticalTextAndDescriptionCellViewModelImp.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

final class RecipeVerticalTextAndDescriptionCellViewModel: VerticalTextAndDescriptionCellViewModel {

    private let recipeEvent: Driver<Recipe>

    init(argument: VerticalTextAndDescriptionCellViewModelArgument) {
        self.recipeEvent = argument.recipeEvent
    }

    func transform(
        input: VerticalTextAndDescriptionCellViewModelInput
    ) -> VerticalTextAndDescriptionCellViewModelOutput {
        return VerticalTextAndDescriptionCellViewModelOutput(
            title: recipeEvent.map { $0.name },
            description: recipeEvent.map { $0.description }
        )
    }
}
