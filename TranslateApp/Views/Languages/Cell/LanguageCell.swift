//
//  LanguageCell.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var flagImage: UILabel!
    @IBOutlet weak var imageFlag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: LanguageModel) {
        lblLanguage.text = data.country ?? " "
        //flagImage.text = emojiFlag(countryCode: data.code ?? "en")
        imageFlag.image = UIImage(named: "flag_\(data.code ?? "")")
    }
    
    func emojiFlag(countryCode: String) -> String {
        var string = ""
        let country = countryCode.uppercased()
        for uS in country.unicodeScalars {
            string.unicodeScalars.append(UnicodeScalar(127397 + uS.value) ?? "0")
        }
        return string
    }
}
