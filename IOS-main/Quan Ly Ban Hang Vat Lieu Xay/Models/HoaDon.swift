//
//  QLVatLieu.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Foundation

class HoaDon {
    var id: String
    var idNhanVien: String
    var nameNhanVien: String
    var khachHang: String
    var sanPham: [[String: Any]]
    var tongTien: String
    var ngayMua: String
    
    //Khoi tao du lieu bang thong tin cho truoc
    init(id: String, idNhanVien: String, nameNhanVien: String, khachHang: String, sanPham: [[String: Any]], tongTien: String, ngayMua: String) {
        self.id = id
        self.idNhanVien = idNhanVien
        self.khachHang = khachHang
        self.nameNhanVien = nameNhanVien
        self.sanPham = sanPham
        self.tongTien = tongTien
        self.ngayMua = ngayMua
    }
    
    //Khoi tao du lieu bang mang [String: Any]
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.idNhanVien = data["idNhanVien"] as! String
        self.khachHang = data["khachHang"] as! String
        self.sanPham = data["sanPham"] as! [[String: Any]]
        self.tongTien = data["tongTien"] as! String
        self.ngayMua = data["ngayMua"] as! String
        self.nameNhanVien = data["nameNhanVien"] as! String
    }
    
    func getData() -> [String: Any] {
        return [
            "id": self.id,
            "idNhanVien": self.idNhanVien,
            "nameNhanVien": self.nameNhanVien,
            "khachHang": self.khachHang,
            "sanPham": self.sanPham,
            "tongTien": self.tongTien,
            "ngayMua": self.ngayMua,
        ]
    }
}
