//
//  QLNhaCungCapViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class QLNhaCungCapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //cac bien anh xa
    @IBOutlet weak var tfTen: CustomTextField!
    @IBOutlet weak var tfDiaChi: CustomTextField!
    @IBOutlet weak var tbNCC: UITableView!
    @IBOutlet weak var btn: UIButton!
    
    //cac bien tu tao
    var db: DBNhaCungCap?
    var arrNCC = [NhaCungCap]()
    var iSelect: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cai dat table
        tbNCC.delegate = self
        tbNCC.dataSource = self
        
        //Khoi tao db
        db = DBNhaCungCap()
        
        loadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if iSelect == -1 {
            btn.setTitle("Sửa", for: .normal)
            self.iSelect = indexPath.row
        } else if iSelect == indexPath.row {
            btn.setTitle("Thêm", for: .normal)
            self.iSelect = -1
        }else {
            self.iSelect = indexPath.row
        }
        
        iSelect != -1 ? updateForm() : clearForm() //neu iSelect khac -1 thi chay updateform con bang thi chay clear form
    }
    
    //Tra ve so luong phan tu
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNCC.count
    }
    
    //set view cho item cua table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNCC") as! NhaCungCapTableViewCell
        
        //set du lieu cho cell
        cell.lbTen.text = "Tên: " + arrNCC[indexPath.row].ten
        cell.lbDiaChi.text = "Địa chỉ: " + arrNCC[indexPath.row].diaChi
        cell.ncc = self
        cell.id = arrNCC[indexPath.row].id
        
        return cell
    }
    
    //Clear form nhap du lieu
    func clearForm() {
        self.tfDiaChi.text = ""
        self.tfTen.text = ""
        self.btn.setTitle("Thêm", for: .normal)
    }
    
    // upload du lieu len form de chinh sua
    func updateForm() {
        self.tfDiaChi.text = arrNCC[iSelect].diaChi
        self.tfTen.text = arrNCC[iSelect].ten
    }
    
    //Load du lieu len table
    func loadData() {
        db!.getAll { (arr) in
            if let arr = arr {
                self.arrNCC.removeAll()
                self.arrNCC = arr
                DispatchQueue.main.async { //Chi co the update view trong thread main
                    self.tbNCC.reloadData()
                }
            }
            
        }
    }
    
    //Tao ra nha cung cap de them vao database
    func getNCCAdd() -> NhaCungCap? {
        
        if tfTen.text! == "" || tfDiaChi.text! == "" {
            showAlert(title: "Chú ý", message: "Bạn chua nhập tên hoặc địa chỉ", action: nil)
            return nil
        }
        
        return NhaCungCap(id: "", ten: tfTen.text!, diaChi: tfDiaChi.text!)
    }
    
    //tao ra nha cung cap de chinh sua
    func getNCCEdit() -> NhaCungCap? {
        
        if tfTen.text! == "" || tfDiaChi.text! == "" {
            showAlert(title: "Chú ý", message: "Bạn chua nhập tên hoặc địa chỉ", action: nil)
            return nil
        }
        return NhaCungCap(id: arrNCC[iSelect].id, ten: tfTen.text!, diaChi: tfDiaChi.text!)
        
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
    
    //hanh dong khi bam nut
    @IBAction func btnAction(_ sender: UIButton) {
        if sender.titleLabel?.text! == "Thêm" {
            if let ncc = getNCCAdd() {
                showLoading(title: "Đang thêm, Đợi tí...")
                db!.addNCC(ncc: ncc) { (error) in
                    if error != nil {
                        self.showAlert(title: "Lỗi", message: "Thêm thất bại"){
                            _ in
                            self.hideLoading()
                        }
                    }else {
                        self.showAlert(title: "Thành công", message: "Thêm thành công"){
                            _ in
                            self.hideLoading()
                        }
                        self.clearForm()
                        self.iSelect = -1
                        self.loadData()
                    }
                }
            }
        } else if sender.titleLabel?.text! == "Sửa" {
            if let ncc = getNCCEdit() {
                showLoading(title: "Đang sửa, Đợi tí...")
                db!.editNCC(ncc: ncc) { (error) in
                    if error != nil {
                        self.showAlert(title: "Lỗi", message: "Sửa thất bại"){
                            _ in
                            self.hideLoading()
                        }
                    }else {
                        self.showAlert(title: "Thành công", message: "Sửa thành công"){
                            _ in
                            self.hideLoading()
                        }
                        self.clearForm()
                        self.iSelect = -1
                        self.loadData()
                    }
                }
            }
        }
    }
}
