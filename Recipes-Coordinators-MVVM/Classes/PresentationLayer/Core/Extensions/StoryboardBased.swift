//
//  StoryboardBased.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/11/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit

protocol StoryboardBased: Instantiatable {
    static var storyboardBundle: Bundle? { get }
    static var storyboardName: String { get }
    static var storyboardIdentifier: String? { get }
}

extension StoryboardBased where Self: UIViewController {

    static var storyboardBundle: Bundle? {
        return .main
    }

    static var storyboardIdentifier: String? {
        return className
    }

    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        if let storyboardIdentifier = storyboardIdentifier {
            return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
        } else {
            return storyboard.instantiateInitialViewController() as! Self
        }
    }
}
