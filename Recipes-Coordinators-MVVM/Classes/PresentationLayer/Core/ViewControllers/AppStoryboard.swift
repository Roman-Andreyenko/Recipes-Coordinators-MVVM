//
//  AppStoryboard.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/18/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit

enum AppStoryboard: String {

    case main

    private var instance: UIStoryboard {
        return UIStoryboard(name: rawValue.capitalizingFirstLetter(), bundle: .main)
    }

    func instantiateViewController<T: UIViewController>(of type: T.Type) -> T {
        return instance.instantiateViewController(withIdentifier: type.storyboardIdentifier) as! T
    }

    func instantiateInitialViewController<T: UIViewController>(of type: T.Type) -> T {
        return instance.instantiateInitialViewController() as! T
    }
}
