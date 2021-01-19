//
//  Utils.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import UIKit

class Utils {
    class func setInitialView(_ window: UIWindow?) {
        
        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()

    }
}
