//
//  HistoryVC.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import UIKit

class HistoryVC: BaseViewControllor {

    @IBOutlet weak var tbvHistory: UITableView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    private let cellHistory = "HistoryCell"
    let vm = HistoryVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        bindData()
        vm.getHistory()
    }
    
    func initView(){
        self.tbvHistory.register(UINib(nibName: cellHistory, bundle: nil), forCellReuseIdentifier: cellHistory)
        self.tbvHistory.tableFooterView = UIView()
    }

    @IBAction func favoriteAct(_ sender: Any) {
        let lst = vm.historys.value?.filter({$0.isSave == 1})
        vm.historys.accept(lst)
    }
    
    @IBAction func backAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func bindData(){
        vm.historys.subscribe(onNext: { (_) in
            self.tbvHistory.reloadData()
        }).disposed(by: disposeBag)

    }
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.historys.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellHistory, for: indexPath) as? HistoryCell, let historys = vm.historys.value else {
            return UITableViewCell()
        }
        var data: HistoryModel?
        if historys.count > indexPath.row {
            data = historys[indexPath.row]
        }
        if let data = data {
            cell.configCell(data: data)
            cell.deleteClouse = {
                self.vm.deleteHistory(id: data.id)
            }
            cell.saveClouse = {
                self.vm.updateHistorySave(id: data.id, isSave: data.isSave == 1 ? 0 : 1)
            }
        }
        return cell
    }
    
}

