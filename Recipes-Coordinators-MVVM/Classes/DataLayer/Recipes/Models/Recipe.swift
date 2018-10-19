//
//  Recipe.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Foundation

struct Recipe {
    let name: String
    let description: String?
    let pictureUrl: URL?
    let steps: [RecipeStep]?
}
