//
//  TableViewCell.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

class TableViewCell: UITableViewCell, Reusable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configureView() {}
    
    func configureConstraints() {}
}

