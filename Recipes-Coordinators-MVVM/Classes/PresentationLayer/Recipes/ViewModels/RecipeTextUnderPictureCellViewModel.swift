//
//  TextUnderPictureCellViewModelImp.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa
import RxSwift

final class RecipeTextUnderPictureCellViewModel: TextUnderPictureCellViewModel {

    let isCheckerSelected: BehaviorRelay<Bool>
    private let recipe: Driver<Recipe>
    private let isCheckerHidden: Bool

    init(argument: RecipeTextUnderPictureCellViewModelArgument) {
        self.recipe = argument.recipe
        self.isCheckerSelected = BehaviorRelay(value: argument.isCheckerSelected)
        self.isCheckerHidden = argument.isCheckerHidden
    }

    func transform(input: TextUnderPictureCellViewModelInput) -> TextUnderPictureCellViewModelOutput {
        let checkedEvent = input.isCheckerSelected.map { [weak self] isSelected -> Bool in
            self?.isCheckerSelected.accept(!isSelected)
            return !isSelected
        }
        let recipeName: Driver<String?> = recipe.map { $0.name }
        return TextUnderPictureCellViewModelOutput(
            text: recipeName,
            picture: Driver.just(#imageLiteral(resourceName: "RecipeExample")),
            isCheckerSelected: Driver<Bool>.merge([isCheckerSelected.asDriver(), checkedEvent]),
            isCheckerHidden: Driver.of(isCheckerHidden)
        )
    }
}

extension RecipeTextUnderPictureCellViewModel: Identifiable {
    static var identifier: String {
        return String(describing: type(of: TextUnderPictureCellViewModel.self))
    }
}
