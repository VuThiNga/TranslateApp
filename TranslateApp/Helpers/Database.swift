//
//  Database.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import Foundation
import SQLite3

class Database {
    static let shared = Database()
    var db: OpaquePointer?
    
    func connect() -> Bool {
        // database file from resource
        guard let fileURL = Bundle.main.resourceURL?.appendingPathComponent(Constants.DATABASE_NAME) else {
            return false
        }
        
        // copy database file from resource to app support directory in order to able to edit file
        let fileMng = FileManager.default
        var destURL: URL!
        do {
            destURL = try fileMng.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            destURL = destURL.appendingPathComponent(Constants.DATABASE_NAME)
            if fileMng.fileExists(atPath: destURL.path) == false {
                do {
                    try fileMng.copyItem(at: fileURL, to: destURL)
                } catch let err {
                    print("copy sqlite file failed: \(err.localizedDescription)")
                    return false
                }
            }
        } catch {
            return false
        }
        
        // open database
        guard sqlite3_open(destURL.path, &db) == SQLITE_OK else {
            print("error opening database")
            sqlite3_close(db)
            db = nil
            return false
        }
        
        return true
    }
    
    func getData<T: BaseDatabaseModel>(query: String, model: T.Type) -> [T] {
        if db == nil {
            if !connect() {
                return []
            }
        }
        
        //
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            return []
        }
        
        var values = [T]()
        while sqlite3_step(statement) == SQLITE_ROW {
            if let stmt = statement {
                let value = T(statement: stmt)
                values.append(value)
            }
        }
        
        sqlite3_finalize(statement)
        return values
    }
    
    /// return (status, message). If status is true, the execution was success.
    func execute(_ query: String) -> (Bool, String?) {
        if db == nil {
            if !connect() {
                return (false, "Could not open database file")
            }
        }
        
        var statement: OpaquePointer?
        var msg: String?
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                msg = "Execution was not success"
            }
        } else {
            msg = "Statement is not prepared"
        }
        
        sqlite3_finalize(statement)
        if msg != nil {
            return (false, msg)
        }
        return (true, nil)
    }
}
