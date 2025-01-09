//
//  ViewController.swift
//  ManufactureMonitoring
//
//  Created by Admin on 02.11.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private var detailView: DetailsView
    private var presenter: DetailsViewPresenter
    
    init(detailView: DetailsView, presenter: DetailsViewPresenter) {
        self.detailView = detailView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        detailView.delegate = self
        addConstraints()
        title = "Детали"
        //setUpView()
        print(DBHelper.shared.detail(by: "1417"))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setUpView() {
       
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension DetailsViewController: DetailInfoViewDelegate {
    func presentVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

