//
//  TextUnderPictureTableViewCell.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/18/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa

class TextUnderPictureTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var textView: UILabel!

}

extension TextUnderPictureTableViewCell: CellConfigurable {

    func configure(with viewModel: TextUnderPictureCellViewModel) {
        let output = viewModel.transform(input: TextUnderPictureCellViewModelInput())
        [output.picture.drive(pictureView.rx.image),
         output.text.drive(textView.rx.text)]
            .forEach {
                $0.disposed(by: rx.reuseBag)
        }
    }
}
