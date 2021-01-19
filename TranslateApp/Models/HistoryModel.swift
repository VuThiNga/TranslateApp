//
//  HistoryModel.swift
//  TranslateApp
//
//  Created by Ngavt on 1/13/21.
//

import Foundation
import SQLite3

class HistoryModel: BaseDatabaseModel {
    var id: Int!
    var languageSource: String!
    var languageDes: String!
    var wordSource: String!
    var wordDes: String!
    var isSave: Int!
    required init(statement: OpaquePointer) {
        super.init(statement: statement)
        let cInt = sqlite3_column_int(statement, 0)
            id = Int(cInt)
        
        if let cString = sqlite3_column_text(statement, 1) {
            languageSource = String(cString: cString)
        }
        if let cString = sqlite3_column_text(statement, 2) {
            languageDes = String(cString: cString)
        }
        if let cString = sqlite3_column_text(statement, 3) {
            wordSource = String(cString: cString)
        }
        if let cString = sqlite3_column_text(statement, 4) {
            wordDes = String(cString: cString)
        }
        let cIntSave = sqlite3_column_int(statement, 5)
        isSave = Int(cIntSave)
        
    }
}
