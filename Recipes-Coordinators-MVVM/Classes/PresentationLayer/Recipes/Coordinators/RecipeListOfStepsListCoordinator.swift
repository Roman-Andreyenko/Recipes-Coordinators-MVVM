//
//  RecipeListOfStepsListCoordinator.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/30/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import RxSwift
import RxCocoa
import Swinject

final class RecipeListOfStepsListCoordinator: BaseCoordinator<Void> {

    private let navigationController: UINavigationController
    private let assembler: Assembler
    private lazy var viewModel: RecipeListOfStepsListViewModel = {
        return assembler.resolver.resolve(
            RecipeListOfStepsListViewModel.self,
            argument: DefaultRecipeListOfStepsListViewModelArgument(resolver: assembler.resolver)
            )!
    }()

    init(parentAssembler: Assembler, navigationController: UINavigationController) {
        self.assembler = Assembler(
            [
                RecipeListOfStepsListAssembly(),
                RecipeStepListAssembly(),
                TextUnderPictureCellViewModelAssembly(),
                VerticalTextAndDescriptionCellViewModelAssembly()
            ],
            parent: parentAssembler)
        self.navigationController = navigationController
    }

    override func start() -> Signal<Void> {

        let viewController = RecipeListOfStepsListViewController.instantiate()
        viewController.bind(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)

        return viewModel.didBack.do(onNext: { [weak self] _ in
            self?.navigationController.popViewController(animated: true)
        })
    }
}
