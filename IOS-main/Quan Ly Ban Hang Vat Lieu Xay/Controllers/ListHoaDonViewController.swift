//
//  ListHoaDonViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class ListHoaDonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tbVIew: UITableView!
    @IBOutlet weak var btnB: UIButton!
    
    var arr = [HoaDon]()
    var arrMacDinh = [HoaDon]()
    var db: DBHoaDon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = DBHoaDon()
        
        //Gan table view
        tbVIew.delegate = self
        tbVIew.dataSource = self
        
        loadData()
        
        txtSearch.addTarget(self, action: #selector(textFieldDidChanger(_:)), for: .editingChanged)
        txtSearch.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
    }
    
    @objc func textFieldDidChanger(_ sender: UITextField){
        if sender.text != "" {
            db!.search(key: sender.text!) { (vl) in
                if let vl = vl {
                    self.arr.removeAll()
                    self.arr = vl
                    DispatchQueue.main.async {
                        self.tbVIew.reloadData()
                    }
                }
            }
        }
    }
    
    func loadData() {
        
        db!.getHoaDon { (vl) in
            if let vl = vl {
                self.arr.removeAll()
                self.arr = vl
                DispatchQueue.main.async {
                    self.tbVIew.reloadData()
                }
            }
        }
    }
    
    @objc func textFieldDidBeginEditing(_ sender: UITextField){
        btnB.setImage(UIImage(named: "Huy"), for: .normal)
        arrMacDinh = arr
    }
    
    @IBAction func btn(_ sender: UIButton) {
        if let tk = UIImage(named: "TimKiem") {
            sender.setImage(tk, for: .normal)
        }
        
        txtSearch.endEditing(true)
        txtSearch.text = ""
        
        arr = arrMacDinh
        DispatchQueue.main.async {
            self.tbVIew.reloadData()
        }
    }
    
    // Xu ly du lieu table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CelHoaDonList") as! ListHoaDonTableViewCell
        
        cell.lbKH.text = arr[indexPath.row].khachHang
        cell.lbNgay.text = arr[indexPath.row].ngayMua
        cell.lbTien.text = arr[indexPath.row].tongTien
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "XemHoaDon") as! HoaDonXemViewController
        vc.id = arr[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
        
    }}
