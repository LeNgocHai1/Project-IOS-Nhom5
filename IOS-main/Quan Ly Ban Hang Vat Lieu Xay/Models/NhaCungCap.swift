//
//  NhaCungCap.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Foundation

class NhaCungCap {
    var id: String
    var ten: String
    var diaChi: String
    
    //Khoi tao du lieu bang thong tin cho truoc
    init(id: String, ten: String, diaChi: String) {
        self.id = id
        self.ten = ten
        self.diaChi = diaChi
    }
    
    //Khoi tao du lieu bang mang [String: Any]
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.ten = data["ten"] as! String
        self.diaChi = data["diaChi"] as! String
    }
    
    func getData() -> [String: Any] {
        return [
            "id": self.id,
            "ten": self.ten,
            "diaChi": self.diaChi
        ]
    }
}
