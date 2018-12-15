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

    var name: String {
        return rawValue.capitalizingFirstLetter()
    }
}
