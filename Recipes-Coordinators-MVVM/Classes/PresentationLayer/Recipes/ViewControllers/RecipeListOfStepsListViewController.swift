//
//  RecipeListOfStepsListViewController.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/6/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class RecipeListOfStepsListViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableViewContainer = BindableTableViewContainer(hostViewController: self, tableView: tableView)
        }
    }
    private var tableViewContainer: BindableTableViewContainer!
}

extension RecipeListOfStepsListViewController: Bindable {

    func bind(with viewModel: RecipeListOfStepsListViewModel) {
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
        tableViewContainer.register(bindableViewControllerType: RecipeStepListViewController.self)
        tableViewContainer.register(bindableCellType: TextUnderPictureTableViewCell.self)
    }

    private func configureInput() -> RecipeListOfStepsListViewModelInput {
        let backButton = UIBarButtonItem(title: "Exit", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = backButton
        let didBack = backButton.rx.tap.asSignal()
        return RecipeListOfStepsListViewModelInput(didBack: didBack)
    }

    private func bind(output: RecipeListOfStepsListViewModelOutput) {
        output.recipes.drive(onNext: { [weak self] items in
            self?.tableViewContainer.update(itemViews: items)
        }).disposed(by: disposeBag)
    }
}

extension RecipeListOfStepsListViewController: StoryboardBased {
    static var storyboardName: String {
        return AppStoryboard.recipes.name
    }
}
