//
//  RecipeListCoordinator.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxSwift

final class RecipeListCoordinator: BaseCoordinator<Void> {

    private unowned let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        
        let viewController = RecipeListViewController.instantiate(from: .recipes, with: RecipeListViewModelImp())
        let navigationController = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return Observable.never()
    }
}
