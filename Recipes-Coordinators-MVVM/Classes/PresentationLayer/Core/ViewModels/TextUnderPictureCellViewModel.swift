//
//  TextUnderPictureCellViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

struct TextUnderPictureCellViewModelInput {
}

struct TextUnderPictureCellViewModelOutput {
    let text: Driver<String?>
    let picture: Driver<UIImage?>
}

struct TextUnderPictureCellViewModelArgument {
    let recipe: Recipe
}

protocol TextUnderPictureCellViewModel: CellViewModel {

    func transform(input: TextUnderPictureCellViewModelInput) -> TextUnderPictureCellViewModelOutput
}
