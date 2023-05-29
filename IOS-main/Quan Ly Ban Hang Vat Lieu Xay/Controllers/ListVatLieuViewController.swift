//
//  ListVatLieuViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class ListVatLieuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Anh xa
    @IBOutlet weak var tbVatLieu: UITableView!
    @IBOutlet weak var tfTimKiem: UITextField!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btnAdd: UIImageView!
    
    //Tao bien
    var arr = [VatLieu]()
    var arrMacDinh = [VatLieu]()
    var db: DBVatLieu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Khoi tao database
        db = DBVatLieu()
        
        //Gan table view
        tbVatLieu.delegate = self
        tbVatLieu.dataSource = self
        
        loadData()
        
        tfTimKiem.addTarget(self, action: #selector(textFieldDidChanger(_:)), for: .editingChanged)
        tfTimKiem.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickButtonAdd))
        
        btnAdd.isUserInteractionEnabled = true
        btnAdd.addGestureRecognizer(gesture)
        
    }
    
    @objc func clickButtonAdd(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ThemVatLieu") as! AddVatLieuViewController
        vc.vc = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldDidChanger(_ sender: UITextField){
        if sender.text != "" {
            db!.search(key: sender.text!) { (vl) in
                if let vl = vl {
                    self.arr.removeAll()
                    self.arr = vl
                    DispatchQueue.main.async {
                        self.tbVatLieu.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func textFieldDidBeginEditing(_ sender: UITextField){
        btn.setImage(UIImage(named: "Huy"), for: .normal)
        arrMacDinh = arr
    }
    
    @IBAction func btnTim(_ sender: UIButton) {
        if let tk = UIImage(named: "TimKiem") {
            sender.setImage(tk, for: .normal)
        }
        
        tfTimKiem.endEditing(true)
        tfTimKiem.text = ""
        
        arr = arrMacDinh
        DispatchQueue.main.async {
            self.tbVatLieu.reloadData()
        }
    }
    
    func loadData() {
        
        db!.getVatLieu { (vl) in
            if let vl = vl {
                self.arr.removeAll()
                self.arr = vl
                DispatchQueue.main.async {
                    self.tbVatLieu.reloadData()
                }
            }
        }
    }
    
    
    
    // Xu ly du lieu table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CelVatLieu") as! VatLieuTableViewCell
        
        cell.id = arr[indexPath.row].id
        cell.imgVatLieu.loadImage(url: arr[indexPath.row].hinh)
        cell.lbTen.text = "Tên: " + arr[indexPath.row].ten
        cell.lbSoLuong.text = "Số lượng: " + String(arr[indexPath.row].soLuong)
        cell.lbNCC.text = "NCC: " + arr[indexPath.row].nhaCungCap
        cell.vatLieuVC = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SuaVatLieu") as! EditVatLieuViewController
            vc.id = arr[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        
    }
}
