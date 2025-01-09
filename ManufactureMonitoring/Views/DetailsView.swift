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
    
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Colors.lightBlue
        return collectionView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
    }
    
}

extension DetailsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.isSearching {
            return presenter.resultsCount
        } else {
            return presenter.numberOfDetails
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else {
            fatalError()
        }
        if presenter.isSearching {
            cell.configure(with: presenter.detailAtSearchResultByIndex(indexPath.row))
        } else {
            cell.configure(with: presenter.detailAtIndex(indexPath.row))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        var detail: Detail
        if presenter.isSearching {
            detail = presenter.detailAtSearchResultByIndex(indexPath.row)
        } else {
           detail = presenter.detailAtIndex(indexPath.row)
        }
        //let detail = presenter.detailAtIndex(indexPath.row)
        let presenter = DetailInfoViewPresenter(detail: detail)
        let vc = DetailInfoViewController(presenter: presenter)
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        delegate?.presentVC(vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = 15
        return CGSize(width: frame.width-CGFloat(2*padding), height: frame.height/10)
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        presenter.numberOfDetails
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else {
//            fatalError()
//        }
//       
//        cell.configure(with: presenter.detailAtIndex(indexPath.row))
//        return cell
//    }
//    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 8
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let detail = presenter.detailAtIndex(indexPath.row)
//        let presenter = DetailInfoViewPresenter(detail: detail)
//        let vc = DetailInfoViewController(presenter: presenter)
//        vc.navigationController?.navigationBar.prefersLargeTitles = true
//        delegate?.presentVC(vc)
//    }
    
}
