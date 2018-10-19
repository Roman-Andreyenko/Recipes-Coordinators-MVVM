//
//  CellConfigurable.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import Foundation

protocol CellConfigurable {
    associatedtype DataType
    func configure(with viewModel: DataType)
}
