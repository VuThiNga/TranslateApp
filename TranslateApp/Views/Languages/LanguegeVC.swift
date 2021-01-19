//
//  LanguegeVC.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import UIKit

class LanguegeVC: BaseViewControllor, UISearchBarDelegate {

    @IBOutlet weak var tbvLanguage: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let languageCell = "LanguageCell"
    private let vm = LanguageVM()
    
    var chooseLanguage: ((LanguageModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        bindData()
        vm.getAllLanguage()
    }

    func initView(){
        self.tbvLanguage.register(UINib(nibName: languageCell, bundle: nil), forCellReuseIdentifier: languageCell)
        self.tbvLanguage.tableFooterView = UIView()
        
    }
    
    @IBAction func backAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func bindData(){
        vm.languageLst.subscribe(onNext: { (_) in
            self.tbvLanguage.reloadData()
        }).disposed(by: disposeBag)
    }
    //MARK: - SearchBar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            let lst = vm.originalLst?.filter({$0.country.contains(searchText.trimmingCharacters(in: .whitespacesAndNewlines))})
            vm.languageLst.accept(lst)
        }else {
            vm.languageLst.accept(vm.originalLst)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension LanguegeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.languageLst.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: languageCell, for: indexPath) as? LanguageCell, let languageLst = vm.languageLst.value else {
            return UITableViewCell()
        }
        var data: LanguageModel?
        if languageLst.count > indexPath.row {
            data = languageLst[indexPath.row]
        }
        if let data = data {
            cell.configCell(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let languageLst = vm.languageLst.value else {
            return
        }
        
        if indexPath.row >= languageLst.count {
            return
        }
        let item = languageLst[indexPath.row]
        self.dismiss(animated: true, completion: {
            if let action = self.chooseLanguage {
                action(item)
            }
        })
        
    }
    
}

