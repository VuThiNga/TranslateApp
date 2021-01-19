//
//  HistoryCell.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var languageSourceLb: UILabel!
    @IBOutlet weak var languageDesLb: UILabel!
    @IBOutlet weak var sourceLb: UILabel!
    @IBOutlet weak var desLb: UILabel!
    @IBOutlet weak var starSaveBtn: UIButton!
    
    var saveClouse: (() -> ())?
    var deleteClouse: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = .none
    }
    
    func configCell(data: HistoryModel) {
        languageSourceLb.text = data.languageSource ?? " "
        languageDesLb.text = data.languageDes ?? " "
        sourceLb.text = data.wordSource ?? " "
        desLb.text = data.wordDes ?? " "
        if data.isSave == 1 {
            starSaveBtn.setImage(UIImage(named: "ic_star_yellow"), for: .normal)
        }else {
            starSaveBtn.setImage(UIImage(named: "ic_star_grey"), for: .normal)
        }
    }
    
    @IBAction func starAct(_ sender: Any) {
        if let action = saveClouse {
            action()
        }
    }
    
    @IBAction func deleteAct(_ sender: Any) {
        if let action = deleteClouse {
            action()
        }
    }
}
