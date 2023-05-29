//
//  KhachHangViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class KhachHangViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Anh xa view
    @IBOutlet weak var tfTen: CustomTextField!
    @IBOutlet weak var tfSDT: CustomTextField!
    @IBOutlet weak var btnActi: UIButton!
    @IBOutlet weak var tbView: UITableView!
    
    var iSelect: Int = -1
    var arrKH = [KhachHang]()
    var db: DBKhachHang?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Khoi tao dbkhachhang
        db = DBKhachHang()
        
        //gan delegate vs datasource cho tbview
        self.tbView.dataSource = self
        self.tbView.delegate = self
        
        //Load data
        loadData()
    }
    
    //Hanh dong khi chap nut Them/Sua
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.titleLabel?.text == "Thêm" {
            themKhachHang()
        }else if sender.titleLabel?.text == "Sửa" {
            suaKhachHang()
        }
    }
    
    //Ham them
    func themKhachHang() {
        if let kh = getAdd() {
            showLoading(title: "Đang thêm, Đợi tí...")
            db?.addKhachHang(kh: kh, completion: { (error) in
                if error == nil {
                    self.loadData()
                    self.iSelect = -1
                    self.clearForm()
                    self.showAlert(title: "Thành công", message: "Thêm thành công") {
                        _ in
                        self.hideLoading()
                    }
                }else{
                    self.showAlert(title: "Thất bại", message: "Thêm thất bại") {
                        _ in
                        self.hideLoading()
                    }
                }
            })
        }
    }
    
    //Ham sua
    func suaKhachHang() {
        if let kh = getEdit() {
            showLoading(title: "Đang sửa, Đợi tí...")
            db?.editKhachHang(kh: kh, completion: { (error) in
                if error == nil {
                    self.loadData()
                    self.clearForm()
                    self.iSelect = -1
                    self.showAlert(title: "Thành công", message: "Sửa thành công") {
                        _ in
                        self.hideLoading()
                    }
                }else{
                    self.showAlert(title: "Thất bại", message: "Sửa thất bại") {
                        _ in
                        self.hideLoading()
                    }
                }
            })
        }
    }
    
    //Ham load du lieu
    func loadData() {
        db?.getKhachHang(completion: { (data) in
            if let data = data {
                self.arrKH.removeAll() //Xoa tat ca du lieu truoc khi cap nhat tranh tinh trang trung
                self.arrKH = data
                
                //Up load view qua main thread
                DispatchQueue.main.async {
                    self.tbView.reloadData()
                }
            }
        })
    }
    
    //Clear form
    func clearForm() {
        tfTen.text = ""
        tfSDT.text = ""
        btnActi.setTitle("Thêm", for: .normal)
    }
    
    //Upload form
    func uploadForm() {
        tfTen.text = arrKH[iSelect].hoTen
        tfSDT.text = arrKH[iSelect].sdt
    }
    
    //Get du lieu tu form
    func getAdd() -> KhachHang? {
        //kiem tra form co trong khong
        if tfTen.text == "" || tfSDT.text == "" {
            showAlert(title: "Chú ý", message: "Phải nhập đủ dữ liệu", action: nil)
            return nil
        }
        
        //Kiem tra dinh dang SDT
        if !tfSDT.text!.isValidSDT() {
            showAlert(title: "Chú ý", message: "SDT không hợp lệ", action: nil)
            return nil
        }
        
        return KhachHang(id: "", hoTen: tfTen.text!, sdt: tfSDT.text!)
    }
    
    func getEdit() -> KhachHang? {
        //kiem tra form co trong khong
        if tfTen.text == "" || tfSDT.text == "" {
            showAlert(title: "Chú ý", message: "Phải nhập đủ dữ liệu", action: nil)
            return nil
        }
        
        //Kiem tra dinh dang SDT
        if !tfSDT.text!.isValidSDT() {
            showAlert(title: "Chú ý", message: "SDT không hợp lệ", action: nil)
            return nil
        }
        
        //Kiem tra index neu bang -1 thi return ve nil
        if iSelect == -1 {
            showAlert(title: "Chú ý", message: "Không nhân dang được id", action: nil)
            return nil
        }
        
        return KhachHang(id: arrKH[iSelect].id, hoTen: tfTen.text!, sdt: tfSDT.text!)
    }
    
    var viewLoading: UIView?
    var lable: UILabel?
    func showLoading(title: String) {
        if let viewLoading = viewLoading, let lable = lable {
            lable.text = title
            viewLoading.isHidden = false
        } else {
            viewLoading = UIView()
            viewLoading!.frame = view.frame
            viewLoading!.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.5)
            
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            
            lable = UILabel()
            lable!.frame = CGRect(x: (width * 0.2) / 2, y: (height * 0.9) / 2, width: width * 0.8, height: height * 0.1)
            lable!.text = title
            lable!.textAlignment = .center
            lable!.textColor = .white
            lable!.font = UIFont.boldSystemFont(ofSize: 20.0)
            
            viewLoading?.addSubview(lable!)
            view.addSubview(viewLoading!)
        }
    }
    
    func hideLoading() {
        if let viewLoading = viewLoading {
            viewLoading.isHidden = true
        }
    }
    
    //hien thi thong bao
    func showAlert(title: String, message: String, action: ((UIAlertAction)->())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) {
            ac in
            action?(ac)
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    //Xu ly du lieu cua table view
    //Tra ve so luong khach hang cho table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrKH.count
    }
    
    //Gan view cho table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellKhachHang") as! KhachHangTableViewCell
        
        cell.id = arrKH[indexPath.row].id
        cell.lbTen.text = arrKH[indexPath.row].hoTen
        cell.lbSDT.text = arrKH[indexPath.row].sdt
        cell.khVC = self
        
        return cell
    }
    
    //Set iselect khi click vao tabel view cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if iSelect == -1 {
            iSelect = indexPath.row
            btnActi.setTitle("Sửa", for: .normal)
        }else if iSelect == indexPath.row {
            iSelect = -1
            btnActi.setTitle("Thêm", for: .normal)
        }else {
            iSelect = indexPath.row
        }
        iSelect != -1 ? uploadForm() : clearForm()
    }
}
