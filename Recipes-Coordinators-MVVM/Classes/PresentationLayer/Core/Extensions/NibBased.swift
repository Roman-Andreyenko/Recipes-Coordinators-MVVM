//
//  NibBased.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/12/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit

protocol NibBased: Instantiatable {
    static var nibBundle: Bundle? { get }
    static var nibName: String { get }
}

extension NibBased where Self: UIViewController {

    static var nibBundle: Bundle? {
        return .main
    }

    static var nibName: String? {
        return className
    }

    static func instantiate() -> Self {
        return Self(nibName: nibName, bundle: nibBundle)
    }
}
