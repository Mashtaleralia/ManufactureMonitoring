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
    
    public func connected() {
        print("connected")
    }
    
    public func selectAllDetails() {
        do {
            for row in try db.prepare("SELECT name, id FROM mytable") {
                    print("name: \(row[0]), id: \(row[1])")
                    // id: Optional(2), email: Optional("betty@icloud.com")
                    // id: Optional(3), email: Optional("cathy@icloud.com")
                }
        } catch {
            print(error)
        }
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
