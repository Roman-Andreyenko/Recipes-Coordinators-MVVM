//
//  TextUnderPictureTableViewCell.swift
//  Recipes-Coordinators-MVVM
//
//  Created by Roman Andreyenko on 10/18/18.
//  Copyright © 2018 Roman Andreyenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TextUnderPictureTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var pictureView: UIImageView!
    @IBOutlet private weak var textView: UILabel!
    @IBOutlet private weak var checkerView: UIButton!
}

extension TextUnderPictureTableViewCell: Bindable {

    func bind(with viewModel: TextUnderPictureCellViewModel) {
        let isCheckerSelected = checkerView.rx.tap.asDriver().map { [weak self] in
            return self?.checkerView.isSelected ?? false
        }
        let input = TextUnderPictureCellViewModelInput(isCheckerSelected: isCheckerSelected)
        let output = viewModel.transform(input: input)
        let checkedEvent = output.isCheckerSelected.map { [weak self] isSelected -> Bool in
            self?.checkerView.tintColor = isSelected ? .green : .gray
            return isSelected
        }
        [output.picture.drive(pictureView.rx.image),
         output.text.drive(textView.rx.text),
         checkedEvent.drive(checkerView.rx.isSelected)]
            .forEach {
                $0.disposed(by: rx.reuseBag)
        }
    }
}
