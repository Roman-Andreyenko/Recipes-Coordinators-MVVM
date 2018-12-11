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

final class RecipeListViewController: UIViewController, ViewModelInitializable {

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!

    var viewModel: RecipeListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerConfigurable(cellType: TextUnderPictureTableViewCell.self)
        tableView.registerConfigurable(cellType: VerticalTextAndDescriptionTableViewCell.self)

        let input = RecipeListViewModelInput(selectRecipeTrigger: tableView.rx.itemSelected.asDriver().map { $0.row })

        let output = viewModel.transform(input: input)

        output.recipes.drive(tableView.rx.items) { tableView, index, cellViewModel in
            let indexPath = IndexPath(row: index, section: 0)
            return tableView.bind(viewModel: cellViewModel, at: indexPath)
        }.disposed(by: disposeBag)
        output.selectedRecipe
            .drive(onNext: { (cellViewModel) in
                print("selected item: \(type(of: cellViewModel).identifier)")
            })
            .disposed(by: disposeBag)
    }
}
