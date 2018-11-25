//
//  VerticalTextAndDescriptionCellViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa

struct VerticalTextAndDescriptionCellViewModelInput {
}

struct VerticalTextAndDescriptionCellViewModelOutput {
    let title: Driver<String?>
    let description: Driver<String?>
}

struct VerticalTextAndDescriptionCellViewModelArgument {
    let recipe: Recipe
}

protocol VerticalTextAndDescriptionCellViewModel: CellViewModel {
    
    func transform(input: VerticalTextAndDescriptionCellViewModelInput) -> VerticalTextAndDescriptionCellViewModelOutput
}
