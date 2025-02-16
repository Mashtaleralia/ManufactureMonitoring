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
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск детали"
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
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
        searchBar.delegate = self
        //setUpView()
        navigationItem.titleView = searchBar
        //print(DBHelper.shared.details(name: "Пята"))
        navigationController?.navigationBar.prefersLargeTitles = true
        hideKeyboardWhenTappedAround()
    }
    
    private func searchByName(_ text: String) {
        presenter.performSearch(by: text)
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

extension DetailsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print(searchBar.text)
        searchByName(searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.isSearching = false
        detailView.collectionView.reloadData()
    }
    
}

extension DetailsViewController: DetailInfoViewDelegate {
    func presentVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)

        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
 }
