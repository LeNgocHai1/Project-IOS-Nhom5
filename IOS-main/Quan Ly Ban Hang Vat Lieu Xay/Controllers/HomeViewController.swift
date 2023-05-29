//
//  HomeViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var lbUID: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var clMenu: UICollectionView!
    
    
    var arrMenu = [
        ["image": UIImage(named: "Customer")!, "name": "QL Khách Hàng"],
        ["image": UIImage(named: "NCC")!, "name": "QL Nhà Cung Cấp"],
        ["image": UIImage(named: "VLXD")!, "name": "DS Vật Liệu"],
        ["image": UIImage(named: "HoaDon")!, "name": "Hoá Đơn"],
        ["image": UIImage(named: "DSHoaDon")!, "name": "DS Hoá Đơn"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    
        clMenu.delegate = self
        clMenu.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Đăng xuất", style: .plain, target: self, action: #selector(logout))
        
        lbUID.text = Auth.auth().currentUser?.email
        let db = DBNhanVien()
        db.getNhanVienByID(id: Auth.auth().currentUser!.uid) { (nv) in
            self.lbName.text = nv?.hoTen
        }
        
    }
    
    @objc func logout(){
        do {
            try Auth.auth().signOut()
            self.navigationController?.dismiss(animated: true, completion: nil)
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DangNhap")
            UIApplication.shared.keyWindow?.rootViewController = viewController
        } catch{}
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMenu", for: indexPath) as! MenuCollectionViewCell
        cell.img.image = arrMenu[indexPath.row]["image"] as? UIImage
        cell.name.text = arrMenu[indexPath.row]["name"] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "QLKhachHang") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "QLNhaCungCap") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case 2:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DanhSachVatLieu") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case 3:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "HoaDonVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        case 4:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DanhSachHoaDon") {
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            print("Sda")
        }
    }
}
