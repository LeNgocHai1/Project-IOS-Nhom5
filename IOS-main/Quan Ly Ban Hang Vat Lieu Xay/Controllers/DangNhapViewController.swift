//
//  DangNhapViewController.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit
import Firebase

class DangNhapViewController: UIViewController {
    @IBOutlet weak var tfEmail: CustomTextField!
    @IBOutlet weak var tfMatKhau: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Noi xay ra hanh dong dang nhap
    @IBAction func btnDangNhap(_ sender: UIButton) {
        if checkData() {
            Auth.auth().signIn(withEmail: tfEmail.text!, password: tfMatKhau.text!) { (result, error) in
                //neu khong lay duoc user va error khong bang nil thi xuat ra thong bao baf return
                guard let _ = result?.user , error == nil else {
                    self.showAlert(title: "Đăng nhập thất bại", message: "Sai tài khoản hoặc mật khẩu")
                    return
                }
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC")
                let navigration = UINavigationController(rootViewController: viewController!)
                UIApplication.shared.keyWindow?.rootViewController = navigration
            }
        }
        
    }
    
    //Kiem tra du lieu truoc khi dang nhap
    func checkData() -> Bool {
        if tfEmail.text!.isValidEmail() && tfMatKhau.text! != "" {
            return true
        }
        showAlert(title: "Chú ý", message: "Chưa nhâp hoặc nhập sai định dạng email, mật khẩu")
        return false
    }
    
    //Chuyen sang man hinh dang ky
    @IBAction func btnDangKy(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DangKy") {
            present(vc, animated: true, completion: nil)
        }
    }
    
    //Hien thi alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
