//
//  ShapeTableViewCell.swift
//  UITestKit_Example
//
//  Created by Eric Internicola on 12/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Cartography
import UIKit

class ShapeTableViewCell: UITableViewCell {

    var shape: Shape? {
        didSet {
            contentChanged()
        }
    }

    let titleLabel = UILabel()
    let shapeImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        shapeImageView.image = nil
    }

}

// MARK: - Implementation

private extension ShapeTableViewCell {

    func buildCell() {
        [titleLabel, shapeImageView].forEach { contentView.addSubview($0) }

        constrain(contentView, titleLabel, shapeImageView) { view, titleLabel, shapeImageView in
            shapeImageView.top == view.top + 4
            shapeImageView.left == view.left + 16
            shapeImageView.bottom == view.bottom - 4
            shapeImageView.width == 80
            shapeImageView.height == 80

            titleLabel.left == shapeImageView.right + 16
            titleLabel.right == view.right - 16
            titleLabel.centerY == shapeImageView.centerY
        }
    }

    func contentChanged() {
        guard let shape = shape else {
            return
        }
        titleLabel.text = shape.rawValue
        shapeImageView.image = shape.image
    }
}
