//
//  RecipeListOfStepsListViewController.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/6/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class RecipeListOfStepsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView!

    var viewModel: RecipeListOfStepsListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // implementation

    var unusedViewControllers: [String: Set<UIViewController>] = [:]
    var usedViewControllers: [IndexPath: UIViewController] = [:]
    var visibleViewControllers: [IndexPath: UIViewController] = [:]

    func add(childViewController: UIViewController) {
        addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
    }

    func remove(childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: nil)
        childViewController.removeFromParentViewController()
    }

    typealias InstantiatableViewController = UIViewController & Instantiatable

    func register(viewControllerType: UIViewController.Type) {
        unusedViewControllers[viewControllerType.reuseId] = Set()
    }

    func dequeueViewController<VC: InstantiatableViewController>(withIdentifier identifier: String) -> VC {
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

    func enqueue(viewController: UIViewController) {
        let identifier = type(of: viewController).reuseId
        guard unusedViewControllers[identifier] != nil else {
            fatalError("UIViewController with reuse identifier: \(identifier) is not registered")
        }
        unusedViewControllers[identifier]?.insert(viewController)
    }

    // delegate

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

    //data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let viewController = dequeueViewController(withIdentifier: "to-do") as
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension RecipeListOfStepsListViewController: StoryboardBased {
    static var storyboardName: String {
        return AppStoryboard.recipes.name
    }
}
