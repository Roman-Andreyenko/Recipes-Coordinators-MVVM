//
//  AppStoryboard.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/18/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit

enum AppStoryboard: String {

    case recipes

    private var instance: UIStoryboard {
        return UIStoryboard(name: rawValue.capitalizingFirstLetter(), bundle: .main)
    }

    func instantiateViewController<T: UIViewController & ViewModelInitializable>(of type: T.Type,
                                                                                 with viewModel: T.ViewModelType) -> T {
        var viewController = instance.instantiateViewController(withIdentifier: type.storyboardIdentifier) as! T
        viewController.viewModel = viewModel
        return viewController
    }

    func instantiateInitialViewController<T: UIViewController & ViewModelInitializable>(of type: T.Type,
                                                                                        with viewModel: T.ViewModelType) -> T {
        var viewController = instance.instantiateInitialViewController() as! T
        viewController.viewModel = viewModel
        return viewController
    }
}
