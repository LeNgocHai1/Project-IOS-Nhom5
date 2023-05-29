//
//  HoaDonViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit
import Firebase

class HoaDonViewController: UIViewController, HoaDonDeleget {
    
    
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbKhachHang: UILabel!
    @IBOutlet weak var lbTongTien: UILabel!
    @IBOutlet weak var lbNgayMua: UILabel!
    @IBOutlet weak var tbSanPham: UITableView!
    @IBOutlet weak var tbKhachHang: UITableView!
    @IBOutlet weak var btnTao: CustomButton!
    @IBOutlet weak var btnHuy: UIButton!
    
    
    private let tableSanPham = TableSanPham()
    private let tableKhachHang = TableKhachHang()
    
    var khid = ""
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set data
        tbSanPham.delegate = tableSanPham.self
        tbSanPham.dataSource = tableSanPham.self
        
        tbKhachHang.delegate = tableKhachHang.self
        tbKhachHang.dataSource = tableKhachHang.self
        
        tableKhachHang.hoaDonDelegate = self
        tableSanPham.hoaDonDelegate = self
        
        loadData()
    }
    
    func loadData() {
        let dbSanPham = DBVatLieu()
        let dbNhaVien = DBNhanVien()
        let dbKhachHang = DBKhachHang()
        
        uid = Auth.auth().currentUser!.uid
        
        dbSanPham.getVatLieu { (vl) in
            if let vl = vl {
                self.tableSanPham.arr = vl
                DispatchQueue.main.async {
                    self.tbSanPham.reloadData()
                }
            }
        }
        
        dbKhachHang.getKhachHang { (kh) in
            if let kh = kh {
                self.tableKhachHang.arr = kh
                DispatchQueue.main.async {
                    self.tbKhachHang.reloadData()
                }
            }
        }
        
        dbNhaVien.getNhanVienByID(id: uid) { (nhanVieb) in
            if let nv = nhanVieb {
                self.lbName.text = nv.hoTen
            }
        }
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        
        lbNgayMua.text = formatter.string(from: date)
        
    }
    
    func selected(index: Int, type: HoaDonType) {
        if type == .KhachHang {
            lbKhachHang.text = tableKhachHang.arr[index].hoTen
            khid = tableKhachHang.arr[index].id
        }
    }
    
    func sanPhamSoLuong(index: Int, soLuong: Int) {}
    
    func update() {
        var temp = 0.0
        
        for item in tableSanPham.arrSanPham {
            temp += Double(item["soLuong"] as! Int) * (item["donGia"] as! Double)
        }
        
        lbTongTien.text = String(temp)
    }
    
    private class TableSanPham: UIViewController , UITableViewDelegate, UITableViewDataSource, HoaDonDeleget {
        func update() {}
        func selected(index: Int, type: HoaDonType) {}
        
        func sanPhamSoLuong(index: Int, soLuong: Int) {
            
            var isBool = false
            
            for item in arrSanPham {
                print(index)
                if arr[index].id == item["id"] as! String {
                    isBool = true
                    break
                }
            }
            
            if isBool {
                arrSanPham[index]["soLuong"] = soLuong
            }else{
                arrSanPham.append(["name": arr[index].ten, "soLuong": soLuong, "id": arr[index].id, "donGia": arr[index].donGia])
            }
            
            hoaDonDelegate!.update()
        }
        
        var arr = [VatLieu]()
        var arrSanPham = [[String: Any]]()
        var hoaDonDelegate: HoaDonDeleget?
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellSanPham") as! SanPhamTableViewCell
            
            cell.img.loadImage(url: arr[indexPath.row].hinh)
            cell.name.text = arr[indexPath.row].ten
            cell.index = indexPath.row
            cell.hoaDonDelegete = self
            
            return cell
        }
    }
    
    private class TableKhachHang: UIViewController , UITableViewDelegate, UITableViewDataSource {
        var arr = [KhachHang]()
        var hoaDonDelegate: HoaDonDeleget?
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellKhachHangHD") as! KhachHangHDTableViewCell
            
            cell.name.text = arr[indexPath.row].hoTen
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            hoaDonDelegate?.selected(index: indexPath.row, type: .KhachHang)
        }
    }
    
//    var id: String
//    var idNhanVien: String
//    var idKhachHang: String
//    var sanPham: [[String: Any]]
//    var tongTien: Double
//    var ngayMua: String
    
    func taoHoaDon() -> HoaDon? {
        if khid == "" {
            let alert = UIAlertController(title: "Chú ý", message: "Bạn chửa nhập đầy đủ thông tin", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
            
            return nil
        }
        
        return HoaDon(id: "", idNhanVien: uid, nameNhanVien: lbName.text!, khachHang: lbKhachHang.text!, sanPham: tableSanPham.arrSanPham, tongTien: lbTongTien.text!, ngayMua: lbNgayMua.text!)
    }
    
    @IBAction func btnTao(_ sender: Any) {
        if let nv = taoHoaDon() {
            let db = DBHoaDon()
            db.addHoaDon(hoaDon: nv) { (error, id) in
                if error == nil && id != nil {
                    let alert = UIAlertController(title: "Thanh cong", message: "Tao thanh công", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "XemHoaDon") as? HoaDonXemViewController {
                            vc.id = id!
                            self.navigationController?.popViewController(animated: true)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func btnHuy(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

enum HoaDonType: String {
    case SanPham
    case KhachHang
}

protocol HoaDonDeleget {
    func selected(index: Int, type: HoaDonType)
    func sanPhamSoLuong(index: Int, soLuong: Int)
    func update()
}

