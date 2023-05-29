//
//  VatLieu.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Foundation

class VatLieu {
    var id: String
    var hinh: String
    var ten: String
    var thongTin: String
    var soLuong: Int
    var donViTinh: String
    var donGia: Double
    var nhaCungCap: String
    
    //Khoi tao du lieu bang thong tin cho truoc
    init(id: String, hinh: String, ten: String, thongTin: String, soLuong: Int, donViTinh: String, donGia: Double, nhaCungCap: String) {
        self.id = id
        self.hinh = hinh
        self.ten = ten
        self.thongTin = thongTin
        self.soLuong = soLuong
        self.donViTinh = donViTinh
        self.donGia = donGia
        self.nhaCungCap = nhaCungCap
    }
    
    //Khoi tao du lieu bang mang [String: Any]
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.hinh = data["hinh"] as! String
        self.ten = data["ten"] as! String
        self.thongTin = data["thongTin"] as! String
        self.soLuong = data["soLuong"] as! Int
        self.donViTinh = data["donViTinh"] as! String
        self.donGia = data["donGia"] as! Double
        self.nhaCungCap = data["nhaCungCap"] as! String
    }
    
    func getData() -> [String: Any] {
        return [
            "id": self.id,
            "hinh": self.hinh,
            "ten": self.ten,
            "thongTin": self.thongTin,
            "soLuong": self.soLuong,
            "donViTinh": self.donViTinh,
            "donGia": self.donGia,
            "nhaCungCap": self.nhaCungCap
        ]
    }
}
