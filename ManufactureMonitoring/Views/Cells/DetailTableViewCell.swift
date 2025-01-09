//
//  DetailTableViewCell.swift
//  ManufactureMonitoring
//
//  Created by Admin on 01.01.2025.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(idLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
        ])
    }
    
    public func configure(with detail: Detail) {
        idLabel.text = "id: " + detail.id
        nameLabel.text = "Haименование: " + detail.Name
    }
    
}
