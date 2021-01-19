//
//  HomeVM.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import Foundation
import RxCocoa
import RxSwift
import AVFoundation

class HomeVM {
    var languageSource = BehaviorRelay<LanguageDisplayModel>(value: LanguageDisplayModel(country: "English", code: "en"))
    var languageDestination = BehaviorRelay<LanguageDisplayModel>(value: LanguageDisplayModel(country: "Vietnamese", code: "vi"))
    
    func readText(_ text:String){
        if let language = NSLinguisticTagger.dominantLanguage(for: text) {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: language)

            //control speed and pitch
            utterance.pitchMultiplier = 1
            utterance.rate = 0.2

            let synth = AVSpeechSynthesizer()
            synth.speak(utterance)

        } else {
            print("Unknown language")
        }
    }
    
    func saveHistory(languageSource: String, languageDes: String, wordSource: String, wordDes: String, isSave: Int) {
        let _ = Database.shared.execute("INSERT INTO history_translate (languageSource, languageDes, wordSource, wordDes, isSave) VALUES ('\(languageSource)', '\(languageDes)', '\(wordSource)', '\(wordDes)', '\(isSave)')")
    }
    
    func updateSave(){
        
    }
}
