//
//  HoaDonXemViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class HoaDonXemViewController: UIViewController {

    @IBOutlet weak var lbNV: UILabel!
    @IBOutlet weak var lbKH: UILabel!
    @IBOutlet weak var lbST: UILabel!
    @IBOutlet weak var lbNgay: UILabel!
    @IBOutlet weak var stSanPham: UIStackView!
    
    var id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = DBHoaDon()
        
        if id != "" {
            db.getHoaDonByID(id: id) { (hd) in
                if let hd = hd {
                    self.lbNV.text = hd.nameNhanVien
                    self.lbKH.text = hd.khachHang
                    self.lbST.text = hd.tongTien
                    self.lbNgay.text = hd.ngayMua
                    
                    for value in hd.sanPham {
                        let lb = UILabel()
                        lb.text = "sss"
                        self.stSanPham.addArrangedSubview(lb)
                    }
                }
            }
        }
    }

}
