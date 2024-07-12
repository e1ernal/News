//
//  NavigationItem.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

public extension UINavigationItem {
    func setTitle(title: String, subtitle: String = "", animating: Bool = false) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .label
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .label.withAlphaComponent(0.6)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.layoutSubviews()
        
        self.titleView = stackView
    }
}
