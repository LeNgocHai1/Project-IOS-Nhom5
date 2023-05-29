//
//  Customer.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Foundation

class KhachHang {
    var id: String
    var hoTen: String
    var sdt: String
    
    //Khoi tao du lieu bang thong tin cho truoc
    init(id: String, hoTen: String, sdt: String) {
        self.id = id
        self.hoTen = hoTen
        self.sdt = sdt
    }
    
    //Khoi tao du lieu bang mang [String: Any]
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.hoTen = data["hoTen"] as! String
        self.sdt = data["sdt"] as! String
    }
    
    func getData() -> [String: Any] {
        return [
            "id": self.id,
            "hoTen": self.hoTen,
            "sdt": self.sdt
        ]
    }
}
