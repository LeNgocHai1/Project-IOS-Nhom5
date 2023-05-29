//
//  CustomStackView.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//
//Tham Khao tai https://stackoverflow.com/questions/34868344/how-to-change-the-background-color-of-uistackview
//

import UIKit

@IBDesignable
class CustomStackView: UIStackView {

    @IBInspectable var color: UIColor? {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var padding: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var isBackground: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isBackground {
            backgroundLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
            
            if let color = color {
                backgroundLayer.fillColor = color.cgColor
            }
            
            layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            isLayoutMarginsRelativeArrangement = true
        }
    }
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()

}
