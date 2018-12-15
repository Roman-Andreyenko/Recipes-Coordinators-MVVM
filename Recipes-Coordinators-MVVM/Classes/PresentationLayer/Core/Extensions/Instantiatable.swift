//
//  Initializable.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/12/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Foundation

protocol Instantiatable {
    static func instantiate() -> Self
}
