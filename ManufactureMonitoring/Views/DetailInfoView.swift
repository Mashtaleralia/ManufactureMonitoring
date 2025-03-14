//
//  DetailInfoView.swift
//  ManufactureMonitoring
//
//  Created by Admin on 04.01.2025.
//

import UIKit

class DetailInfoView: UIView {

    weak var presenter: DetailInfoViewPresenter!
    
    weak var delegate: DetailInfoViewDelegate?
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = Colors.lightBlue
        stack.layer.cornerRadius = 14
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        
        //stack.spacing = 16
        return stack
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var resourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var partyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var parentControl = ParentControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(resourceLabel)
        stackView.addArrangedSubview(durationLabel)
        stackView.addArrangedSubview(partyLabel)
        stackView.addArrangedSubview(typeLabel)
        
        addSubview(stackView)
        addSubview(parentControl)
        addConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        parentControl.addTarget(self, action: #selector(moveToParent), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func moveToParent() {
        if let parent = presenter.getParent() {
            let presenter = DetailInfoViewPresenter(detail: parent)
            let vc = DetailInfoViewController(presenter: presenter)
            delegate?.presentVC(vc)
        }
    }
    
    public func configure() {
        nameLabel.text = "Наименование: " + presenter.name
        resourceLabel.text = "Ресурс: \(presenter.resource)"
        durationLabel.text = "Длительность: \(presenter.duration)"
        partyLabel.text = "Партия: \(presenter.party)"
        typeLabel.text = "Тип: \(presenter.type)"
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            resourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            durationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            partyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3),
            parentControl.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            parentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            parentControl.widthAnchor.constraint(equalToConstant: 100),
            parentControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
