//
//  EmbedableTableViewCell.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 12/31/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit

final class HostTableViewCell: UITableViewCell {
    fileprivate weak var embededView: UIView?

    override func prepareForReuse() {
        super.prepareForReuse()

        embededView?.removeFromSuperview()
        embededView = nil
    }
}

extension HostTableViewCell: HostableView {

    func embed(view: UIView) {
        embededView = view
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
