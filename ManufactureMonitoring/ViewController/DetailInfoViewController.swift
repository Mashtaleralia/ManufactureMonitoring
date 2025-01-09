//
//  DetailInfoViewController.swift
//  ManufactureMonitoring
//
//  Created by Admin on 04.01.2025.
//

import UIKit

class DetailInfoViewController: UIViewController {

    private var detailInfoView: DetailInfoView
    private var presenter: DetailInfoViewPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация"
        view.backgroundColor = Colors.background
        detailInfoView.configure()
        view.addSubview(detailInfoView)
        addConstraints()
    }
    
    init(presenter: DetailInfoViewPresenter) {
        self.presenter = presenter
        self.detailInfoView = DetailInfoView()
        self.detailInfoView.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}
