//
//  BaseViewController.swift
//  TranslateApp
//
//  Created by Ngavt on 1/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewControllor: UIViewController {
    
    var disposeBag = DisposeBag()
    var disposables = [Disposable]()
    var network = URLNetwork()
    
    func encodeUrlTest(word: String, sourceCode: String, destinationCode: String) -> String? {
        let originalString = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=\(sourceCode)&tl=\(destinationCode)&dt=t&ie=UTF-8&oe=UTF-8&q=\(word)"
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return escapedString
    }
}
