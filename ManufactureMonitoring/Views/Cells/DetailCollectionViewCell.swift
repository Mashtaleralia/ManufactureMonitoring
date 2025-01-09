//
//  DetailTableViewCell.swift
//  ManufactureMonitoring
//
//  Created by Admin on 01.01.2025.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailTableViewCell"
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Colors.grey
        //label.backgroundColor = Colors.lightGrey
       // label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(idLabel)
        setUpConstraints()
        layer.cornerRadius = 14
        backgroundColor = Colors.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            idLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
        ])
    }
    
    public func configure(with detail: Detail) {
        idLabel.text = "id: " + detail.id
        nameLabel.text = "Haименование: " + detail.Name
    }
    
}
