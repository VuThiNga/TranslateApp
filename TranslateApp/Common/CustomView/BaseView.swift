//
//  BaseView.swift
//  TranslateApp
//
//  Created by Ngavt on 1/12/21.
//

import UIKit

@IBDesignable
class BaseView: UIView {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    /// cornerRadius is a half of view's height
    @IBInspectable
    var roundBorder: Bool = false {
        didSet {
            if roundBorder {
                cornerRadius = frame.size.height / 2
            }
        }
    }
    
    @IBInspectable
    var rotationAngle: CGFloat = 0 {
        didSet {
            transform = CGAffineTransform(rotationAngle: .pi * rotationAngle / 180)
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor = .lightGray {
        didSet {
            layer.shadowColor = shadowColor.cgColor
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = 0.5
            layer.shadowRadius = shadowRadius
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
}
