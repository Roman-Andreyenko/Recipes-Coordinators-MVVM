//
//  VerticalTextAndDescriptionCellViewModelImp.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

final class VerticalTextAndDescriptionCellViewModelImp: VerticalTextAndDescriptionCellViewModel {

    private let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    func transform(input: VerticalTextAndDescriptionCellViewModelInput) -> VerticalTextAndDescriptionCellViewModelOutput {
        return VerticalTextAndDescriptionCellViewModelOutput(title: Driver.of(recipe.name),
                                                             description: Driver.of(recipe.description))
    }
}

extension VerticalTextAndDescriptionCellViewModelImp: Identifiable {
    var identifier: String {
        return String(describing: type(of: VerticalTextAndDescriptionCellViewModel.self))
    }
}
