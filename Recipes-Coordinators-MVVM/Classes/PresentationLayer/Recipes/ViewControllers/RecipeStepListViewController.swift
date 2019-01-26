//
//  RecipeStepListViewController.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/11/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class RecipeStepListViewController: UIViewController {

    @IBOutlet weak var stepsView: UILabel!

    private let disposeBag = DisposeBag()
}

extension RecipeStepListViewController: StoryboardBased {
    static var storyboardName: String {
        return AppStoryboard.recipes.name
    }
}

extension RecipeStepListViewController: Bindable {
    func bind(with viewModel: RecipeStepListViewModel) {
        rx.viewDidLoad
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.configureView()
                let input = self.configureInput()
                let output = viewModel.transform(input: input)
                self.bind(output: output)
            })
            .disposed(by: disposeBag)
    }

    private func configureView() {
    }

    private func configureInput() -> RecipeStepListViewModelInput {
        return RecipeStepListViewModelInput()
    }

    private func bind(output: RecipeStepListViewModelOutput) {
        output.recipeName
            .drive(stepsView.rx.text)
            .disposed(by: disposeBag)
    }
}

extension RecipeStepListViewController: EmbedableView {
    var embedableView: UIView {
        return view
    }
}
