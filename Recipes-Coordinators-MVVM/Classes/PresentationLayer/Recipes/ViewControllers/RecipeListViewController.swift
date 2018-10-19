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

class RecipeListViewController: BaseViewController, ViewModelInitializable {
    
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: RecipeListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: TextUnderPictureTableViewCell.className, bundle: .main),
                           forCellReuseIdentifier: TextUnderPictureTableViewCell.className)
        tableView.register(UINib(nibName: VerticalTextAndDescriptionTableViewCell.className, bundle: .main),
                           forCellReuseIdentifier: VerticalTextAndDescriptionTableViewCell.className)

        let input = RecipeListViewModelInput(selectRecipeTrigger: tableView.rx.itemSelected.asDriver().map { $0.row })

        let output = viewModel.transform(input: input)

        output.recipes.drive(tableView.rx.items) { tableView, index, cellViewModel in
            let indexPath = IndexPath(row: index, section: 0)
            if let cellViewModel = cellViewModel as? TextUnderPictureCellViewModel {
                let cell = tableView.dequeueReusableCell(withIdentifier: TextUnderPictureTableViewCell.className,
                                                         for: indexPath) as! TextUnderPictureTableViewCell
                cell.configure(with: cellViewModel)
                return cell
            } else if let cellViewModel = cellViewModel as? VerticalTextAndDescriptionCellViewModel {
                let cell = tableView.dequeueReusableCell(withIdentifier: VerticalTextAndDescriptionTableViewCell.className,
                                                         for: indexPath) as! VerticalTextAndDescriptionTableViewCell
                cell.configure(with: cellViewModel)
                return cell
            } else {
                return UITableViewCell()
            }
        }.disposed(by: disposeBag)
        output.selectedRecipe.drive {
            print("selected item")
        }.disposed(by: disposeBag)
    }
}
