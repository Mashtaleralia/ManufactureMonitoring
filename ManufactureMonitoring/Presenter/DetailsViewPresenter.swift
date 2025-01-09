//
//  DetailsViewPresenter.swift
//  ManufactureMonitoring
//
//  Created by Admin on 01.01.2025.
//

import Foundation

protocol DetailsViewPresenterProtocol {
    
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    
    private var detailView: DetailsView
    private var details: [Detail]
    private var dbService = DBHelper.shared
    private var searchResults = [Detail]()
    
    var isSearching = false
    
    init(view: DetailsView) {
        self.detailView = view
        self.details = dbService.fetchAllDetails()
    }
    
    var numberOfDetails: Int {
        return details.count
    }
    
    var resultsCount: Int {
        return searchResults.count
    }
    
    func fetchDetails() {
        self.details = dbService.fetchAllDetails()
        
    }
    
    func getSearchResults() -> [Detail] {
        return searchResults
    }
    
    func detailAtSearchResultByIndex(_ index: Int) -> Detail {
        return searchResults[index]
    }
    
    func detailAtIndex(_ index: Int) -> Detail {
        return details[index]

    }
    
    func performSearch(by name: String) {
        isSearching = true
        self.searchResults = dbService.details(name: name)
        detailView.collectionView.reloadData()
        //isSearching = false
    }
    
    
}
