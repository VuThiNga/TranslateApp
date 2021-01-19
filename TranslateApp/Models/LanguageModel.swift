//
//  LanguageModel.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import Foundation
import SQLite3

class LanguageModel: BaseDatabaseModel {
    var country: String!
    var code: String!
    required init(statement: OpaquePointer) {
        super.init(statement: statement)
        if let cString = sqlite3_column_text(statement, 0) {
            country = String(cString: cString)
        }
        if let cString = sqlite3_column_text(statement, 1) {
            code = String(cString: cString)
        }
    }
}

class LanguageDisplayModel {
    var country: String?
    var code: String?
    
    init(country: String, code: String) {
        self.country = country
        self.code = code
    }
}

