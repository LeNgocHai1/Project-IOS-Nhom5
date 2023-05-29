//
//  DBHoaDon.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Firebase

class DBHoaDon {
    var db = Firestore.firestore().collection("HoaDon");
    
    func addHoaDon(hoaDon: HoaDon, completion: @escaping (Error?, String?)->()) {
        
        hoaDon.id = db.document().documentID
        
        db.document(hoaDon.id).setData(hoaDon.getData()) { (error) in
            completion(error, hoaDon.id)
        }
    }
    
    func getHoaDonByID(id: String, completion: @escaping (HoaDon?)->()) {
        db.document(id).getDocument { (document, error) in
            if let data = document?.data() {
                completion(HoaDon(data: data))
            } else {
                completion(nil)
            }
        }
    }
    
    func getHoaDon(completion: @escaping ([HoaDon]?)->()) {
        db.getDocuments { (snap, error) in
            if let snap = snap?.documents, error == nil {
                var arr = [HoaDon]()
                for item in snap {
                    arr.append(HoaDon(data: item.data()))
                }
                completion(arr)
            }
        }
    }
    
    func search(key: String, completion: @escaping ([HoaDon]?)->()) {
        db.getDocuments { (snap, error) in
            if let snap = snap?.documents, error == nil {
                var arr = [HoaDon]()
                for item in snap {
                    let temp = HoaDon(data: item.data())
                    if temp.khachHang.contains(key) {
                        arr.append(temp)
                    }
                }
                completion(arr)
            }
        }
    }
}
