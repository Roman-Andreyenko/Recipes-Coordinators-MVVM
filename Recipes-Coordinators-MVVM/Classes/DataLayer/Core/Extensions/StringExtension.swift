//
//  StringExtension.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/18/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Foundation

extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
}
