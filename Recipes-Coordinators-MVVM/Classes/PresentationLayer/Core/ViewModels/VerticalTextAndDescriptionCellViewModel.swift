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

protocol VerticalTextAndDescriptionCellViewModel: ViewModel, Identifiable {
    
    func transform(input: VerticalTextAndDescriptionCellViewModelInput) -> VerticalTextAndDescriptionCellViewModelOutput
}

extension VerticalTextAndDescriptionCellViewModel {
    static var identifier: String {
        return String(describing: type(of: VerticalTextAndDescriptionCellViewModel.self))
    }
}
