//
//  TextUnderPictureCellViewModel.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxCocoa
import RxSwift

struct TextUnderPictureCellViewModelInput {
    let checkTrigger: Driver<Bool>
}

struct TextUnderPictureCellViewModelOutput {
    let text: Driver<String?>
    let picture: Driver<UIImage?>
    let checkedEvent: Driver<Bool>
}

protocol TextUnderPictureCellViewModel: CellViewModel {

    var isSelectedRelay: BehaviorRelay<Bool> { get }
    func transform(input: TextUnderPictureCellViewModelInput) -> TextUnderPictureCellViewModelOutput
}
