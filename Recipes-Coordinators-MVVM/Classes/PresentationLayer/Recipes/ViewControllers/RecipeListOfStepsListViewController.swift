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

final class RecipeListOfStepsListViewController: UIViewController, ViewModelInitializable {

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!

    var viewModel: RecipeListOfStepsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func add(childViewController: UIViewController) {
        addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
    }

    func remove(childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.removeFromParentViewController()
    }
}
