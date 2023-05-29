//
//  CustomTextView.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextView: UITextView {
    @IBInspectable var boder: CGFloat = 0 {
        didSet {
            textContainerInset = UIEdgeInsets(top: textContainerInset.top + 5, left: 10, bottom: textContainerInset.top + 5, right: 10)
            layer.borderWidth = 1
            layer.borderColor = UIColor(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1.0).cgColor
            layer.cornerRadius = boder
        }
    }
    
}

//Code sau duoc lay tai link https://stackoverflow.com/questions/27652227/add-placeholder-text-inside-uitextview-in-swift
extension UITextView {
    
    private class PlaceholderLabel: UILabel { }
    
    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = font
            label.textColor = .gray
            addSubview(label)
            return label
        }
    }
    
    @IBInspectable
    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 0
            let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding + 10, y: textContainerInset.top + 5)
            
            textStorage.delegate = self
        }
    }
    
}

extension UITextView: NSTextStorageDelegate {
    
    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
    
}
