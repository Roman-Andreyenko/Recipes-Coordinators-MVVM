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

final class RecipeListCoordinator: BaseCoordinator<Void> {

    private let assembler: Assembler

    init(parentAssembler: Assembler) {
        self.assembler = Assembler(
            [
                RecipeListAssembly(),
                TextUnderPictureCellViewModelAssembly(),
                VerticalTextAndDescriptionCellViewModelAssembly()
            ],
            parent: parentAssembler)
    }

    override func start() -> Observable<Void> {
        
        let viewController = RecipeListViewController
            .instantiate(from: .recipes,
                         with: assembler.resolver.resolve(
                            RecipeListViewModel.self,
                             argument: DefaultRecipeListViewModelArgument(resolver: assembler.resolver)))
        let navigationController = UINavigationController(rootViewController: viewController)

        let rootWindow = assembler.resolver.resolve(UIWindow.self, name: DependencyNames.UIKit.rootWindow.rawValue)!
        rootWindow.rootViewController = navigationController
        rootWindow.makeKeyAndVisible()

        return Observable.never()
    }
}
