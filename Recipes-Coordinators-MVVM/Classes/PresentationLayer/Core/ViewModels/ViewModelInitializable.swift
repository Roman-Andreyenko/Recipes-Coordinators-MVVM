//
//  ViewModelInitializable.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit

protocol ViewModelInitializable {
    associatedtype ViewModelType
    var viewModel: ViewModelType { get set }
}

extension ViewModelInitializable where Self: UIViewController {

    static func instantiate(from storyboard: AppStoryboard, with viewModel: ViewModelType) -> Self {
        var viewController = storyboard.instantiateViewController(of: self, with: viewModel)
        viewController.viewModel = viewModel
        return viewController
    }
}
