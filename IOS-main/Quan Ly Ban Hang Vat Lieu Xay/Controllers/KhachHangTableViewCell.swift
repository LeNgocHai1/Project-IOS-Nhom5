//
//  KhachHangTableViewCell.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class KhachHangTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTen: UILabel!
    @IBOutlet weak var lbSDT: UILabel!
    var khVC: KhachHangViewController?
    var id: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //Thuc hien delete
    @IBAction func btdDelete(_ sender: UIButton) {
        let db = DBKhachHang()
        if id != "" {
            let alert = UIAlertController(title: "Cảnh báo", message: "Bạn thật sự muốn xoá", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                db.delKhachHang(id: self.id, completion: { (error) in
                    if error == nil {
                        self.khVC?.iSelect = -1
                        self.khVC?.loadData()
                        self.khVC?.clearForm()
                        self.showAlert(title: "Thành công", message: "Bạn đã xoá thành công")
                    }else{
                        self.showAlert(title: "Thất bại", message: "Bạn đã xoá thất bại")
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
            khVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    //Hien thi alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        khVC?.present(alert, animated: true, completion: nil)
    }
}
