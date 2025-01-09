//
//  DetailsView.swift
//  ManufactureMonitoring
//
//  Created by Admin on 01.01.2025.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    
}

protocol DetailInfoViewDelegate: AnyObject {
    func presentVC(_ vc: UIViewController)
}

class DetailsView: UIView, DetailsViewDelegate {
    
    weak var presenter: DetailsViewPresenter!
    
    weak var delegate: DetailInfoViewDelegate?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
}

extension DetailsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfDetails
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else {
            fatalError()
        }
        cell.accessoryType = .detailDisclosureButton
        cell.configure(with: presenter.detailAtIndex(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 8
    }
    
    
}
