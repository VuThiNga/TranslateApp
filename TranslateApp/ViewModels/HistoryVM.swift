//
//  HistoryVM.swift
//  TranslateApp
//
//  Created by Ngavt on 1/13/21.
//

import Foundation
import RxCocoa
import RxSwift

class HistoryVM {
    var historys = BehaviorRelay<[HistoryModel]?>(value: nil)
   
    func getHistory(){
        let hiss = Database.shared.getData(query: "SELECT id, languageSource, languageDes, wordSource, wordDes, isSave FROM history_translate order by id desc", model: HistoryModel.self)
        historys.accept(hiss)
    }
    
    func updateHistorySave(id: Int, isSave: Int) {
        let _ = Database.shared.execute("UPDATE history_translate SET isSave = '\(isSave)' WHERE id = \(id)")
        getHistory()
    }
    
    func deleteHistory(id: Int) {
        let _ = Database.shared.execute("DELETE FROM history_translate WHERE id = '\(id)'")
        getHistory()
    }
    
    func updateNewHistory(){
        let hiss = Database.shared.getData(query: "SELECT id, languageSource, languageDes, wordSource, wordDes, isSave FROM history_translate order by id desc", model: HistoryModel.self)
        if hiss.count > 0 {
            updateHistorySave(id: hiss[0].id, isSave: 1)
        }
    }
}
