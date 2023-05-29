//
//  DBNhaCungCap.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Firebase

class DBNhaCungCap {
    var db = Firestore.firestore().collection("NhaCungCap")
    
    func addNCC(ncc: NhaCungCap, completion: @escaping (Error?) -> ()) {
        let id = db.document().documentID
        ncc.id = id
        
        db.document(id).setData(ncc.getData()){
            data in
            completion(data)
        }
    }
    
    func delNCCByID(id: String, completion: @escaping (Error?) -> ()) {
        db.document(id).delete(){
            error in
            completion(error)
        }
    }
    
    func editNCC(ncc: NhaCungCap, completion: @escaping (Error?) -> ()) {
        db.document(ncc.id).setData(ncc.getData()){
            data in
            completion(data)
        }
    }
    
    func getAll(completion: @escaping ([NhaCungCap]?) -> ()) {
        db.getDocuments { (snap, error) in
            if let snap = snap?.documents, error == nil {
                var arr = [NhaCungCap]()
                for item in snap {
                    arr.append(NhaCungCap(data: item.data()))
                }
                completion(arr)
            }
        }
    }
}
