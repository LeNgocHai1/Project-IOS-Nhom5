//
//  HoaDonTableViewCell.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class SanPhamTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var soLuong: CustomTextField!
    
    var hoaDonDelegete: HoaDonDeleget?
    var index: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        soLuong.addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
    }
    
    @objc func didEndEditing(){
        
        if let soLuong = Int(soLuong!.text!) , index != -1 {
            hoaDonDelegete!.sanPhamSoLuong(index: index, soLuong: soLuong)
        } else if index != -1 {
            hoaDonDelegete!.sanPhamSoLuong(index: index, soLuong: 0)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        soLuong.endEditing(true)
    }

}
