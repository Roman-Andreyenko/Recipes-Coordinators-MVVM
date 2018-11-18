//
//  ReactiveExtension.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

private var prepareForReuseBag: Int8 = 0

@objc protocol Reusable : class {
    func prepareForReuse()
    static var cellReuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    static var cellReuseIdentifier: String {
        return className
    }
}
extension UITableViewHeaderFooterView: Reusable {
    static var cellReuseIdentifier: String {
        return className
    }
}
extension UICollectionReusableView: Reusable {
    static var cellReuseIdentifier: String {
        return className
    }
}

extension Reactive where Base: Reusable {
    var prepareForReuse: Observable<Void> {
        return Observable.of(sentMessage(#selector(Base.prepareForReuse)).map { _ in }, deallocated).merge()
    }
    
    var reuseBag: DisposeBag {
        MainScheduler.ensureExecutingOnScheduler()
        
        if let bag = objc_getAssociatedObject(base, &prepareForReuseBag) as? DisposeBag {
            return bag
        }
        
        let bag = DisposeBag()
        objc_setAssociatedObject(base, &prepareForReuseBag, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        _ = sentMessage(#selector(Base.prepareForReuse))
            .subscribe(onNext: { [weak base] _ in
                guard let base = base else {
                    return
                }
                let newBag = DisposeBag()
                objc_setAssociatedObject(base, &prepareForReuseBag, newBag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            })
        
        return bag
    }
}