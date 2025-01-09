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
    
    private var detailView: DetailsViewDelegate
    private var details: [Detail]
    private var dbService = DBHelper.shared
    
    init(view: DetailsViewDelegate) {
        self.detailView = view
        self.details = dbService.fetchAllDetails()
    }
    
    var numberOfDetails: Int {
        return details.count
    }
    
    func fetchDetails() {
        self.details = dbService.fetchAllDetails()
        
    }
    
    func detailAtIndex(_ index: Int) -> Detail {
        return details[index]
    }
    
    
}
