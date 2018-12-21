//
//  VerticalTextAndDescriptionTableViewCell.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/19/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa

class VerticalTextAndDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleView: UILabel!
    @IBOutlet private weak var descriptionView: UILabel!

}

extension VerticalTextAndDescriptionTableViewCell: Bindable {
    
    func bind(with viewModel: VerticalTextAndDescriptionCellViewModel) {
        let output = viewModel.transform(input: VerticalTextAndDescriptionCellViewModelInput())
        [output.title.drive(titleView.rx.text),
         output.description.drive(descriptionView.rx.text)]
            .forEach {
                $0.disposed(by: rx.reuseBag)
        }
    }
}
