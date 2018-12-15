//
//  ReuseIdentifiable.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/12/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable {
    static var reuseId: String { get }
}

extension UIViewController: ReuseIdentifiable  {
    static var reuseId: String {
        return className
    }
}

extension UITableViewCell: ReuseIdentifiable {
    static var reuseId: String {
        return className
    }
}

extension ReuseIdentifiable where Self: UITableViewHeaderFooterView {
    static var reuseId: String {
        return className
    }
}

extension ReuseIdentifiable where Self: UICollectionReusableView {
    static var reuseId: String {
        return className
    }
}
