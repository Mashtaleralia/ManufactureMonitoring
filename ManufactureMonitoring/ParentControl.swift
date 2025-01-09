//
//  ParentControl.swift
//  ManufactureMonitoring
//
//  Created by Admin on 06.01.2025.
//

import UIKit

class ParentControl: UIControl {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Родитель"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.grey
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 7
        addSubview(label)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
//            label.widthAnchor.constraint(equalToConstant: 100),
//            leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -5),
//            trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
        ])
    }
    
}
