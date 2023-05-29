//
//  Personnel.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Foundation

class NhanVien {
    var id: String
    var email: String
    var hoTen: String
    var diaChi: String
    
    //Khoi tao du lieu bang thong tin cho truoc
    init(id: String, email: String, hoTen: String, diaChi: String) {
        self.id = id
        self.email = email
        self.hoTen = hoTen
        self.diaChi = diaChi
    }
    
    //Khoi tao du lieu bang mang [String: Any]
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.email = data["email"] as! String
        self.hoTen = data["hoTen"] as! String
        self.diaChi = data["diaChi"] as! String
    }
    
    func getData() -> [String: Any] {
        return [
            "id": self.id,
            "email": self.email,
            "hoTen": self.hoTen,
            "diaChi": self.diaChi
        ]
    }
}
