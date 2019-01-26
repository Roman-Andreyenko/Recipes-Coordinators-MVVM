//
//  BindableTableViewContainer.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 1/5/19.
//  Copyright © 2019 Roman Andreyenko. All rights reserved.
//

import UIKit

final class BindableTableViewContainer: NSObject {

    private unowned let tableView: UITableView
    private unowned let hostViewController: UIViewController

    private var unusedViewControllers: [String: Set<UIViewController>] = [:]
    private var usedViewControllers: [IndexPath: UIViewController] = [:]
    private var visibleViewControllers: [IndexPath: UIViewController] = [:]
    private var itemViews: [IdentifiableViewModel] = []
    var viewControllerFactories: [String: ViewControllerFactory] = [:]

    init(hostViewController: UIViewController, tableView: UITableView) {
        self.hostViewController = hostViewController
        self.tableView = tableView
    }

    func update(itemViews: [IdentifiableViewModel]) {
        tableView.delegate = self
        tableView.dataSource = self
        self.itemViews = itemViews
        tableView.reloadData()
    }

    typealias BindableViewController = UIViewController & Instantiatable & Bindable & EmbedableView

    func register<BVC: BindableViewController>(bindableViewControllerType: BVC.Type) {
        let viewModelType = String(describing: type(of: bindableViewControllerType.DataType.self))
        unusedViewControllers[bindableViewControllerType.reuseId] = Set()
        tableView.register(cellType: HostTableViewCell.self)

        viewControllerFactories[viewModelType] = createViewControllerFactory(viewControllerType: bindableViewControllerType)
    }

    typealias BindableCell = UITableViewCell & Bindable

    func register<BC: BindableCell>(bindableCellType: BC.Type) {
        tableView.registerConfigurable(cellType: bindableCellType)
    }

    private func add(childViewController: UIViewController) {
        hostViewController.addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: hostViewController)
    }

    private func remove(childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.removeFromParentViewController()
    }

    typealias InstantiatableViewController = UIViewController & Instantiatable

    private func bindView(with viewModel: IdentifiableViewModel, at indexPath: IndexPath) -> UITableViewCell {
        if let cell = viewControllerFactories[type(of: viewModel).identifier]?(tableView, indexPath, viewModel) {
            return cell
        } else {
            return tableView.bindCell(with: viewModel, at: indexPath)
        }
    }

    private func dequeueViewController<VC: InstantiatableViewController>(viewControllerType: VC.Type,
                                                                 withIdentifier identifier: String) -> VC {
        guard let unusedIdentifiableViewControllers = unusedViewControllers[identifier] else {
            fatalError("UIViewController with reuse identifier: \(identifier) is not registered")
        }

        if let unusedViewController = unusedIdentifiableViewControllers.first {
            unusedViewControllers[identifier]?.remove(unusedViewController)
            return unusedViewController as! VC
        } else {
            return VC.instantiate()
        }
    }

    private func enqueue(viewController: UIViewController) {
        let identifier = type(of: viewController).reuseId
        guard unusedViewControllers[identifier] != nil else {
            fatalError("UIViewController with reuse identifier: \(identifier) is not registered")
        }
        unusedViewControllers[identifier]?.insert(viewController)
    }

    typealias ViewControllerFactory = (UITableView, IndexPath, IdentifiableViewModel) -> UITableViewCell

    private func createViewControllerFactory<BVC: BindableViewController>(
        viewControllerType: BVC.Type
        ) -> ViewControllerFactory {
        let viewControllerFactory: ViewControllerFactory = { [weak self] tableView, indexPath, itemViewModel in
            guard let `self` = self else { return UITableViewCell() }
            let viewController = self.dequeueViewController(viewControllerType: viewControllerType,
                                                                            withIdentifier: BVC.reuseId)
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HostTableViewCell.reuseId,
                for: indexPath
                ) as! HostTableViewCell
            if let itemViewModel = itemViewModel as? BVC.DataType {
                viewController.bind(with: itemViewModel)
            }
            cell.embed(view: viewController.embedableView)
            return cell
        }
        return viewControllerFactory
    }
}

extension BindableTableViewContainer: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewController = usedViewControllers.removeValue(forKey: indexPath) else {
            return
        }
        visibleViewControllers[indexPath] = viewController
        add(childViewController: viewController)
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewController = visibleViewControllers.removeValue(forKey: indexPath) else {
            return
        }
        remove(childViewController: viewController)
        enqueue(viewController: viewController)
    }
}

extension BindableTableViewContainer: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = itemViews[indexPath.row]
        return bindView(with: viewModel, at: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemViews.count
    }
}
