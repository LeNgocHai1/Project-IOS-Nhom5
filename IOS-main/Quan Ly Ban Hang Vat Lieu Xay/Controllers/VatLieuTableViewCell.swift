//
//  VatLieuTableViewCell.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class VatLieuTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVatLieu: UIImageView!
    @IBOutlet weak var lbTen: UILabel!
    @IBOutlet weak var lbSoLuong: UILabel!
    @IBOutlet weak var lbNCC: UILabel!
    
    //Tao bien
    var id = ""
    var vatLieuVC: ListVatLieuViewController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnDelete(_ sender: Any) {
        let db = DBVatLieu()
        if id != "" {
            let alert = UIAlertController(title: "Cảnh báo", message: "Bạn thật sự muốn xoá", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                db.delVatLieu(id: self.id, completion: { (error) in
                    if error == nil {
                        self.vatLieuVC?.loadData()
                        self.showAlert(title: "Thành công", message: "Bạn đã xoá thành công")
                    }else{
                        self.showAlert(title: "Thất bại", message: "Bạn đã xoá thất bại")
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
            vatLieuVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    //Hien thi alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vatLieuVC?.present(alert, animated: true, completion: nil)
    }
}
