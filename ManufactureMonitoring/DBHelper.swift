//
//  DBHelper.swift
//  ManufactureMonitoring
//
//  Created by Admin on 04.11.2024.
//

import Foundation
import SQLite

class DBHelper {
    
    static let shared = DBHelper()
    
    private let db: Connection
    
    init() {
        let dbUrl = Bundle.main.url(forResource: "nasos", withExtension: "db")
        let dbPath = dbUrl!.path
        self.db = try! Connection(dbPath)
    }
    
    func connected() {
        print("connected")
    }
    
    func fetchAllDetails() -> [Detail] {
        var details = [Detail]()
        do {
            for row in try db.prepare("SELECT * FROM mytable") {
               
                let detail = Detail(Name: row[0] as! String, id: row[1] as! String, id_2: row[2] as! Int64, id_3: row[3] as! Int64, parent: row[4] as! Int64, dur: row[5] as! Int64, t_sht: row[6] as! Double, t_pz: row[7] as! Double, party: row[8] as! Double, _tr: row[9] as! String, twenty: row[10] as! String)
                print(detail)
                details.append(detail)
            }
            
        } catch {
            print(error)
        }
        return details
    }
    
    func detail(by id: String) -> Detail? {
        var detail: Detail?
        do {
            for row in try db.prepare("SELECT * FROM mytable WHERE id == \(id)") {
                detail = Detail(Name: row[0] as! String, id: row[1] as! String, id_2: row[2] as! Int64, id_3: row[3] as! Int64, parent: row[4] as! Int64, dur: row[5] as! Int64, t_sht: row[6] as! Double, t_pz: row[7] as! Double, party: row[8] as! Double, _tr: row[9] as! String, twenty: row[10] as! String)
            }
        } catch {
            print(error)
        }
        return detail
    }
    
    
    
//    func query() {
//      var queryStatement: OpaquePointer?
//      // 1
//      if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
//          SQLITE_OK {
//        // 2
//        if sqlite3_step(queryStatement) == SQLITE_ROW {
//          // 3
//          let id = sqlite3_column_int(queryStatement, 0)
//          // 4
//          guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
//            print("Query result is nil")
//            return
//          }
//          let name = String(cString: queryResultCol1)
//          // 5
//          print("\nQuery Result:")
//          print("\(id) | \(name)")
//      } else {
//          print("\nQuery returned no results.")
//      }
//      } else {
//          // 6
//        let errorMessage = String(cString: sqlite3_errmsg(db))
//        print("\nQuery is not prepared \(errorMessage)")
//      }
//      // 7
//      sqlite3_finalize(queryStatement)
//    }


}
