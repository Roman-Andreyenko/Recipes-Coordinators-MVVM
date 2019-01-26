//
//  RecipeListCoordinator.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

final class RecipeListCoordinator: BaseCoordinator<Void> {

    private let assembler: Assembler
    private lazy var viewModel: RecipeListViewModel = {
        return assembler.resolver.resolve(
            RecipeListViewModel.self,
            argument: DefaultRecipeListViewModelArgument(resolver: assembler.resolver)
        )!
    }()

    init(parentAssembler: Assembler) {
        self.assembler = Assembler(
            [
                RecipeListAssembly(),
                TextUnderPictureCellViewModelAssembly(),
                VerticalTextAndDescriptionCellViewModelAssembly()
            ],
            parent: parentAssembler)
    }

    override func start() -> Signal<Void> {
        
        let viewController = RecipeListViewController.instantiate()
        viewController.bind(with: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)

        let rootWindow = assembler.resolver.resolve(UIWindow.self, name: DependencyNames.UIKit.rootWindow.rawValue)!
        rootWindow.rootViewController = navigationController
        rootWindow.makeKeyAndVisible()

        viewModel.isRecipeSelected
            .flatMap { [weak self] _ -> Signal<Void> in
                guard let `self` = self else { return .empty() }
                return self.coordinate(to: RecipeListOfStepsListCoordinator(
                    parentAssembler: self.assembler,
                    navigationController: navigationController
                ))
            }
            .emit()
            .disposed(by: disposeBag)

        return Signal.never()
    }
}
