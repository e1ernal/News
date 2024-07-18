//
//  TableView.swift
//  News
//
//  Created by e1ernal on 17.07.2024.
//

import UIKit

public extension UITableView {
    func setBackgroundView(title: String, subtitle: String, image: String) {
        // Set view to empty tableView
        let backgroundLabel = UILabel()
        backgroundLabel.textAlignment = .center
        backgroundLabel.numberOfLines = 0

        let imageAttachment = NSTextAttachment()
        let image = UIImage(
            systemName: image /* "newspaper" */ ,
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        )?.withTintColor(.label)

        imageAttachment.image = image
        let imageString = NSAttributedString(attachment: imageAttachment)

        let backgroundText = NSMutableAttributedString()
        backgroundText.append(imageString)

        let titleText = title /* "\nNo News" */
        let subtitleText = subtitle /* "\nTry to change the search parameters\nor come back later" */
        backgroundText.append(NSAttributedString(string: titleText + subtitleText))

        let titleFontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)]
        let subtitleFontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)]
        let mainColorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let secondaryColorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]

        backgroundText.addAttributes(
            titleFontAttribute,
            range: NSRange(location: 1, length: titleText.count)
        )

        backgroundText.addAttributes(
            subtitleFontAttribute,
            range: NSRange(location: titleText.count + 1, length: subtitleText.count)
        )

        backgroundText.addAttributes(
            mainColorAttribute,
            range: NSRange(location: 1, length: titleText.count)
        )

        backgroundText.addAttributes(
            secondaryColorAttribute,
            range: NSRange(location: titleText.count + 1, length: subtitleText.count)
        )

        backgroundLabel.attributedText = backgroundText

        self.backgroundView = backgroundLabel
    }
    
    func clearBackgroundView() {
        self.backgroundView = nil
    }
}
