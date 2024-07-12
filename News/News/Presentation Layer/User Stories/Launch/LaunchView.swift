//
//  LaunchView.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

final class LaunchView: UIView {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configure View
        addSubview(titleLabel)
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        
        let welcomeText = "Welcome to"
        let fullText = welcomeText + "\n" + title
        let attributedText = NSMutableAttributedString(string: fullText)
        
        let fontSizeAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50, weight: .bold)]
        let mainColorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let secondaryColorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        
        attributedText.addAttributes(fontSizeAttribute, range: NSRange(location: 0, length: fullText.count))
        attributedText.addAttributes(secondaryColorAttribute, range: NSRange(location: 0, length: welcomeText.count))
        attributedText.addAttributes(mainColorAttribute, range: NSRange(location: welcomeText.count, length: title.count))
        
        titleLabel.attributedText = attributedText
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Configure constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: LaunchView.self))") }
}

