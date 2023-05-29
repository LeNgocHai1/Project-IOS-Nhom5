//
//  DBVatLieu.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import Firebase

class DBVatLieu {
    var db = Firestore.firestore().collection("VatLieu")
    var storage = Storage.storage()
    
    func addVatLieu(vl: VatLieu, completion: @escaping (Error?)->()) {
        let id = db.document().documentID
        vl.id = id
        
        db.document(id).setData(vl.getData()){
            error in
            completion(error)
        }
    }
    
    func uploadImage(image: UIImage, name: String, completion: @escaping (String?)->()) {
        let ref = storage.reference().child("images/" + name)
        let uploadTask = ref.putData(image.jpegData(compressionQuality: 0.3)!, metadata: nil) { (metadata, error) in
            if let _ = metadata, error == nil {
                ref.downloadURL(completion: { (url, error) in
                    if let url = url, error == nil {
                        completion(url.absoluteString)
                    }
                })
            }
        }
        uploadTask.resume()
    }
    
    func delVatLieu(id: String, completion: @escaping (Error?)->()) {
        db.document(id).delete(){
            error in
            completion(error)
        }
    }
    
    func editVatLieu(vl: VatLieu, completion: @escaping (Error?)->()) {
        db.document(vl.id).setData(vl.getData()){
            error in
            completion(error)
        }
    }
    
    func getVatLieu(completion: @escaping ([VatLieu]?)->()) {
        db.getDocuments { (snap, error) in
            if let snap = snap?.documents, error == nil {
                var arr = [VatLieu]()
                for item in snap {
                    arr.append(VatLieu(data: item.data()))
                }
                completion(arr)
            }
        }
    }
    
    func getVatLieuID(id: String, completion: @escaping (VatLieu?)->()) {
        db.document(id).getDocument { (snap, error) in
            if let snap = snap, error == nil {
                completion(VatLieu(data: snap.data()!))
            }
        }
    }
    
    func search(key: String, completion: @escaping ([VatLieu]?)->()) {
        db.getDocuments { (snap, error) in
            if let snap = snap?.documents, error == nil {
                var arr = [VatLieu]()
                for item in snap {
                    let temp = VatLieu(data: item.data())
                    if temp.ten.contains(key) {
                        arr.append(temp)
                    }
                }
                completion(arr)
            }
        }
    }
}
