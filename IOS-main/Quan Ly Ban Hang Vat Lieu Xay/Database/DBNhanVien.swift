//
//  DBNhanVien.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Firebase

class DBNhanVien {
    var db = Firestore.firestore().collection("NhanVien");
    
    func addNhanVien(nhanVien: NhanVien, completion: @escaping (Error?)->()) {
        db.document(nhanVien.id).setData(nhanVien.getData()) { (error) in
            completion(error)
        }
    }
    
    func getNhanVienByID(id: String, completion: @escaping (NhanVien?)->()) {
        db.document(id).getDocument { (document, error) in
            if let data = document?.data() {
                completion(NhanVien(data: data))
            } else {
                completion(nil)
            }
        }
    }
    
    func delNhanVien(id: String, completion: @escaping (Error?)->()) {
        db.document(id).delete() { (error) in
            completion(error)
        }
    }
}
