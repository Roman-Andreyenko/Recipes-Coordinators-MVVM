//
//  UITableViewExtension.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import Foundation

struct AssociatedKeys {
    static var viewModelToCellMap: UInt8 = 0
}

extension UITableView {

    typealias BindableCell = UITableViewCell & Bindable
    private typealias CellFactory = (UITableView, IndexPath, IdentifiableViewModel) -> UITableViewCell

    func bindCell(with viewModel: IdentifiableViewModel, at indexPath: IndexPath) -> UITableViewCell {
        return cellTypeMap[type(of: viewModel).identifier]?(self, indexPath, viewModel) ?? UITableViewCell()
    }

    func registerConfigurable<Cell: BindableCell>(cellType: Cell.Type) {
        let viewModelType = String(describing: type(of: cellType.DataType.self))
        register(cellType: cellType)

        cellTypeMap.updateValue(createCellFactory(cellType: cellType), forKey: viewModelType)
    }

    func register<Cell: UITableViewCell>(cellType: Cell.Type) {
        register(UINib(nibName: cellType.className, bundle: .main),
                 forCellReuseIdentifier: cellType.reuseId)
    }

    private var cellTypeMap: [String: CellFactory] {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys
                .viewModelToCellMap) as? [String: CellFactory] else {
                return [:]
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.viewModelToCellMap,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private func createCellFactory<Cell: BindableCell>(
        cellType: Cell.Type
        ) -> CellFactory {
        let cellFactory: CellFactory = { tableView, indexPath, cellViewModel in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Cell.reuseId,
                for: indexPath
                ) as! Cell
            if let cellViewModel = cellViewModel as? Cell.DataType {
                cell.bind(with: cellViewModel)
            }
            return cell
        }
        return cellFactory
    }
}
