//
//  RecipeListViewController.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class RecipeListViewController: UIViewController {

    private let disposeBag = DisposeBag()
    @IBOutlet private weak var tableView: UITableView!

}

extension RecipeListViewController: Bindable {

    func bind(with viewModel: RecipeListViewModel) {
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
        self.tableView.registerConfigurable(cellType: TextUnderPictureTableViewCell.self)
        self.tableView.registerConfigurable(cellType: VerticalTextAndDescriptionTableViewCell.self)
    }

    private func configureInput() -> RecipeListViewModelInput {
        return RecipeListViewModelInput(selectRecipeTrigger: tableView.rx.itemSelected.asDriver().map { $0.row })
    }

    private func bind(output: RecipeListViewModelOutput) {
        output.recipes.drive(tableView.rx.items) { tableView, index, cellViewModel in
            let indexPath = IndexPath(row: index, section: 0)
            return tableView.bindCell(with: cellViewModel, at: indexPath)
            }.disposed(by: disposeBag)
        output.selectedRecipe
            .drive(onNext: { (cellViewModel) in
                print("selected item: \(type(of: cellViewModel).identifier)")
            })
            .disposed(by: disposeBag)
    }
}

extension RecipeListViewController: StoryboardBased {
    static var storyboardName: String {
        return AppStoryboard.recipes.name
    }
}
