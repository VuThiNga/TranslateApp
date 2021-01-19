//
//  BaseButton.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import UIKit

@IBDesignable
class BaseButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            viewSetup()
        }
    }
    @IBInspectable var round: Bool = false {
        didSet {
            viewSetup()
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            viewSetup()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            viewSetup()
        }
    }
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            viewSetup()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            viewSetup()
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            viewSetup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewSetup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        viewSetup()
    }
    private func viewSetup() {
        if round {
            layer.cornerRadius = frame.height / 2
        } else {
            layer.cornerRadius = cornerRadius
        }
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.shadowColor = shadowColor.cgColor
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        
        setTitle(titleLabel?.text, for: .normal)
    }
}
