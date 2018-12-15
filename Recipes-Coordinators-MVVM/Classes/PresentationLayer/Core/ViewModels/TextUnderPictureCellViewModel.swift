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
    let isCheckerSelected: Driver<Bool>
}

struct TextUnderPictureCellViewModelOutput {
    let text: Driver<String?>
    let picture: Driver<UIImage?>
    let isCheckerSelected: Driver<Bool>
    let isCheckerHidden: Driver<Bool>
}

protocol TextUnderPictureCellViewModel: ViewModel, Identifiable {

    var isCheckerSelected: BehaviorRelay<Bool> { get }
    func transform(input: TextUnderPictureCellViewModelInput) -> TextUnderPictureCellViewModelOutput
}

extension TextUnderPictureCellViewModel {
    static var identifier: String {
        return String(describing: type(of: TextUnderPictureCellViewModel.self))
    }
}
