//
//  LanguageVM.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import Foundation
import RxCocoa

class LanguageVM {
    //language list
    var languageLst = BehaviorRelay<[LanguageModel]?>(value: nil)
    var originalLst: [LanguageModel]?
    
    func getAllLanguage() {
        let languages = Database.shared.getData(query: "SELECT country, code from CodeLanguage", model: LanguageModel.self)
        originalLst = languages
        languageLst.accept(languages)
    }
}

