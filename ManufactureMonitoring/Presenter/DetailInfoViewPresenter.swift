//
//  DetailInfoViewPresenter.swift
//  ManufactureMonitoring
//
//  Created by Admin on 04.01.2025.
//

import Foundation

class DetailInfoViewPresenter {
    
    private var detail: Detail
    
    init(detail: Detail) {
        self.detail = detail
    }
    
    var name: String {
        return detail.Name
    }
    
    var resource: Double {
        var dur = Double(detail.dur)
        dur = dur == 0 ? dur + 1 : dur
                        
        return (detail.t_sht * detail.party + detail.t_pz) / dur
    }
    
    var duration: Double {
        var dur = Double(detail.dur)
        dur = dur == 0 ? dur + 1 : dur
        return dur
    }
    
    var party: Double {
        return detail.party
    }
    
    var type: String {
        return detail._tr
    }
    
    func getParent() -> Detail? {
        return DBHelper.shared.detail(by: String(detail.parent))
    }
    
}
