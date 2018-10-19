//
//  TextUnderPictureCellViewModelImp.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

final class TextUnderPictureCellViewModelImp: TextUnderPictureCellViewModel {

    private let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    func transform(input: TextUnderPictureCellViewModelInput) -> TextUnderPictureCellViewModelOutput {
        return TextUnderPictureCellViewModelOutput(text: Driver.of(recipe.name), picture: Driver.just(#imageLiteral(resourceName: "RecipeExample")))
    }
}
extension TextUnderPictureCellViewModelImp: Identifiable {
    var identifier: String {
        return String(describing: type(of: TextUnderPictureCellViewModel.self))
    }
}
