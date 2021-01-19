//
//  HomeVC.swift
//  TranslateApp
//
//  Created by Ngavt on 1/11/21.
//

import UIKit
import ADCountryPicker
import AVFoundation
import GoogleMobileAds

class HomeVC: BaseViewControllor {

    @IBOutlet weak var textViewSource: UITextView!
    @IBOutlet weak var textViewDestination: UITextView!
    @IBOutlet weak var viewSource: BaseView!
    @IBOutlet weak var viewDestination: BaseView!
    @IBOutlet weak var lbSource: UILabel!
    @IBOutlet weak var lbDestination: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    private let vm = HomeVM()
    private let vmHistory = HistoryVM()
    
    var translateSuccess: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        bindData()
        bannerView.adUnitID = "ca-app-pub-3933534186672942~6225976316"
        bannerView.rootViewController = self
        let request: GADRequest = GADRequest()
        bannerView.load(request)
    }
    
    func bindData(){
        vm.languageSource.subscribe(onNext: { (_) in
            self.lbSource.text = self.vm.languageSource.value.country ?? " English"
        }).disposed(by: disposeBag)
        
        vm.languageDestination.subscribe(onNext: { (_) in
            self.lbDestination.text = self.vm.languageDestination.value.country ?? " Vietnamese"
        }).disposed(by: disposeBag)
    }
    
    func initView(){
        textViewSource.placeholder = "Nhập văn bản"
        let sourceGesture = UITapGestureRecognizer(target: self, action: #selector(touchViewSource))
        viewSource.addGestureRecognizer(sourceGesture)
        let destinationGesture = UITapGestureRecognizer(target: self, action: #selector(touchViewDestination))
        viewDestination.addGestureRecognizer(destinationGesture)
    }
    
    @objc func touchViewSource(){
        let vc = LanguegeVC(nibName: "LanguegeVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.chooseLanguage = { chooseLanguage in
            let language = LanguageDisplayModel(country: chooseLanguage.country, code: chooseLanguage.code)
            self.vm.languageSource.accept(language)
        }
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func touchViewDestination(){
        let vc = LanguegeVC(nibName: "LanguegeVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.chooseLanguage = { chooseLanguage in
            self.clearTextField()
            let language = LanguageDisplayModel(country: chooseLanguage.country, code: chooseLanguage.code)
            self.vm.languageDestination.accept(language)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    private func clearTextField() {
        self.textViewSource.text = ""
        self.textViewDestination.text = ""
    }

    @IBAction func clearTextAct(_ sender: Any) {
        clearTextField()
    }
    
    @IBAction func openHistoryAct(_ sender: Any) {
        let vc = HistoryVC(nibName: "HistoryVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func openMenuAct(_ sender: Any) {
//        let messageModel = Database.shared.getData(query: "SELECT errorCode, messageVn, messageEn FROM onepay_error_message WHERE errorCode = \(errorCode ?? "Other")", model: OnepayErrorMessage.self)
    }
    
    @IBAction func copyAct(_ sender: Any) {
        if textViewDestination.text != "" {
            UIPasteboard.general.string = textViewDestination.text
        }
    
    }
    
    @IBAction func starAct(_ sender: Any) {
        if translateSuccess, textViewDestination.text != "" {
            vmHistory.updateNewHistory()
        }
    }
    
    @IBAction func switchLanguageAct(_ sender: Any) {
        textViewSource.text = ""
        textViewDestination.text = ""
        let sourceLanguage = self.vm.languageSource.value
        let destinationLanguage = self.vm.languageDestination.value
        self.vm.languageSource.accept(destinationLanguage)
        self.vm.languageDestination.accept(sourceLanguage)
    }
    
    @IBAction func translateAct(_ sender: Any) {
        translateSuccess = false
        textViewSource.resignFirstResponder()
        textViewDestination.resignFirstResponder()
        if textViewSource.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            //popup validate
            return
        }
        if let urlString = self.encodeUrlTest(word: textViewSource.text, sourceCode: self.vm.languageSource.value.code ?? "en", destinationCode: self.vm.languageDestination.value.code ?? "vi") {
            network.loadJson(fromURLString: urlString, completion: { (str, error) in
                DispatchQueue.main.async {
                    if let strResult = str {
                        self.translateSuccess = true
                        self.textViewDestination.text = strResult
                        self.vm.saveHistory(languageSource: self.vm.languageSource.value.code ?? "en", languageDes: self.vm.languageDestination.value.code ?? "vi", wordSource: self.textViewSource.text, wordDes: strResult, isSave: 0)
                    }else {
                        self.textViewDestination.text = self.textViewSource.text
                    }
                }
                
            })
        }
    }
}
