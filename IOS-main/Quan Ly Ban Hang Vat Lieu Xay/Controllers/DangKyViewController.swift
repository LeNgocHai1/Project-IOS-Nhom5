//
//  ViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit
import Firebase

class DangKyViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: CustomTextField!
    @IBOutlet weak var tfMatKhau: CustomTextField!
    @IBOutlet weak var tfMatKhau1: CustomTextField!
    @IBOutlet weak var tfHoTen: CustomTextField!
    @IBOutlet weak var tfDiaChi: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Noi xay ra su kien dang ky
    @IBAction func dangKy(_ sender: UIButton) {
        let db = DBNhanVien() //Tao ra bien Database Nhanview
        
        if let nhanVien = getNhanVien() {
            Auth.auth().createUser(withEmail: nhanVien.email, password: tfMatKhau.text!) { (result, error) in
                if let user = result?.user , error == nil {
                    nhanVien.id = user.uid
                    db.addNhanVien(nhanVien: nhanVien) {error in
                        if error == nil {
                            self.showAlert(title: "Thành công", message: "Tao Tài khoản thành công") {
                                self.dismiss(animated: true, completion: nil)
                            }
                        } else {
                            self.showAlert(title: "Thất bại", message: "Tao Tài khoản thất bại", action: nil)
                        }
                    }
                } else {
                    self.showAlert(title: "Lỗi tạo tài khoản", message: "Email đã được sữ dụng, và cũng có thể là lỗi server. Xin thử lại sau ít phút", action: nil)
                }
            }
        }
        
    }
    
    //huy view controller nay de tro loi view controller truoc. Cu the la VC Dang Nhap
    @IBAction func btnDangNhap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //Ham lay nhan vien de dang ky
    func getNhanVien() -> NhanVien? {
        
        //Kiem tra cac o nhap khong trong
        if  tfEmail.text == "" || tfMatKhau.text != tfMatKhau1.text ||
            tfDiaChi.text == "" || tfMatKhau1.text == "" ||
            tfMatKhau.text == "" {
            showAlert(title: "Chú ý", message: "Chưa nhập đầy đủ thông tin", action: nil)
            return nil
        }
        
        //Kiem tra dinh dang mail
        if !tfEmail.text!.isValidEmail(){
            showAlert(title: "Chú ý", message: "Sai định dạng email", action: nil)
            return nil
        }
        
        //Kiem tra 2 mat khau nhap vao la bang nhau
        if tfMatKhau.text! != tfMatKhau1.text! {
            showAlert(title: "Chú ý", message: "Mật khẩu không khớp", action: nil)
            return nil
        }
        
        //kiem tra mat khau phai lon hon 6 ki tu
        if tfMatKhau.text!.count < 6 {
            showAlert(title: "Chú ý", message: "Mật khẩu phải dài hơn hoặc bằng 6 ký tự", action: nil)
            return nil
        }
        
        return NhanVien(id: "", email: tfEmail.text!, hoTen: tfHoTen.text!, diaChi: tfDiaChi.text!)
    }
    
    //Hien thi alert
    func showAlert(title: String, message: String, action: (()->())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            action?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//Ham check email nay duoc kiem tren stackoverflow
//Link: https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidSDT() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[^0-9.]", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) == nil
    }
}
