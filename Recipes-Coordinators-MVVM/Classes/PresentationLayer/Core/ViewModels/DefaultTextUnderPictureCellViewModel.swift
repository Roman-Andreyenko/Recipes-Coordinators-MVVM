//
//  TextUnderPictureCellViewModelImp.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

final class DefaultTextUnderPictureCellViewModel: TextUnderPictureCellViewModel {

    private let recipe: Recipe

    init(argument: TextUnderPictureCellViewModelArgument) {
        self.recipe = argument.recipe
    }

    func transform(input: TextUnderPictureCellViewModelInput) -> TextUnderPictureCellViewModelOutput {
        return TextUnderPictureCellViewModelOutput(text: Driver.of(recipe.name), picture: Driver.just(#imageLiteral(resourceName: "RecipeExample")))
    }
}
extension DefaultTextUnderPictureCellViewModel: Identifiable {
    var identifier: String {
        return String(describing: type(of: TextUnderPictureCellViewModel.self))
    }
}
