//
//  UniversalUnits.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import UIKit

class tableCustom: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUpTable()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpTable()
    }
    func setUpTable() {
        layer.zPosition = 1
        backgroundColor = UIColor.myBackgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        separatorStyle = UITableViewCell.SeparatorStyle.none
        showsVerticalScrollIndicator = false
        }
}

class UniversalButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.textAlignment = .center
        setTitleColor(UIColor.myBlue, for: .normal)
        titleLabel?.font = UIFont(name: "Arial", size: 19)
        titleLabel?.numberOfLines = 2
        layer.zPosition = 2
        clipsToBounds = true
        alpha = 1.0
        isEnabled = true
    }
}
