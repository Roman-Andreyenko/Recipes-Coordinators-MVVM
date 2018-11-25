//
//  VerticalTextAndDescriptionCellViewModelImp.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

final class DefaultVerticalTextAndDescriptionCellViewModel: VerticalTextAndDescriptionCellViewModel {

    private let recipe: Recipe

    init(argument: VerticalTextAndDescriptionCellViewModelArgument) {
        self.recipe = argument.recipe
    }

    func transform(input: VerticalTextAndDescriptionCellViewModelInput) -> VerticalTextAndDescriptionCellViewModelOutput {
        return VerticalTextAndDescriptionCellViewModelOutput(title: Driver.of(recipe.name),
                                                             description: Driver.of(recipe.description))
    }
}

extension DefaultVerticalTextAndDescriptionCellViewModel: Identifiable {
    var identifier: String {
        return String(describing: type(of: VerticalTextAndDescriptionCellViewModel.self))
    }
}
