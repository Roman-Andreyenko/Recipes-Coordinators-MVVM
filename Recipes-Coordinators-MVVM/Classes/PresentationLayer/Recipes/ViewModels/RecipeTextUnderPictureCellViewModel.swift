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

    let isSelectedRelay: BehaviorRelay<Bool>
    private let recipeEvent: Driver<Recipe>

    init(argument: TextUnderPictureCellViewModelArgument) {
        self.recipeEvent = argument.recipeEvent
        self.isSelectedRelay = BehaviorRelay(value: argument.isSelected)
    }

    func transform(input: TextUnderPictureCellViewModelInput) -> TextUnderPictureCellViewModelOutput {
        let checkedEvent = input.checkTrigger.map { [weak self] isSelected -> Bool in
            self?.isSelectedRelay.accept(!isSelected)
            return !isSelected
        }
        let recipeName: Driver<String?> = recipeEvent.map { $0.name }
        return TextUnderPictureCellViewModelOutput(text: recipeName,
                                                   picture: Driver.just(#imageLiteral(resourceName: "RecipeExample")),
                                                   checkedEvent: Driver<Bool>.merge([isSelectedRelay.asDriver(),
                                                                                     checkedEvent]))
    }
}
extension RecipeTextUnderPictureCellViewModel: Identifiable {
    var identifier: String {
        return String(describing: type(of: TextUnderPictureCellViewModel.self))
    }
}
