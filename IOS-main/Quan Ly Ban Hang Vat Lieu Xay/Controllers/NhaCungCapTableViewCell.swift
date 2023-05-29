//
//  NhaCungCapTableViewCell.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class NhaCungCapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTen: UILabel!
    @IBOutlet weak var lbDiaChi: UILabel!
    
    var id = "" //Lay id de phuc vu cho muc dich xoa
    var ncc: QLNhaCungCapViewController? //Lay class QLNhaCungCapViewController de hien thi alert dialog
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //Hanh dong xoa NCC theo id
    @IBAction func btnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Chú Ý", message: "Bạn có muốn xoá?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (style) in
            if self.id != "" {
                self.ncc?.db!.delNCCByID(id: self.id, completion: { (error) in
                    if error == nil {
                        //Tao ra alert de thong bao hoan thanh viec xoa
                        self.showAlert(title: "Thành công", message: "Xoá thành công")
                        self.ncc?.loadData()
                        self.ncc?.clearForm()
                        self.ncc?.iSelect = -1 //De chac chan iSelect bang -1 khi xoa
                    }else{
                        //Tao ra alert de thong bao bi lỗi trong lúc xoá
                        self.showAlert(title: "Thất bại", message: "Xoá thất bại")
                    }
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        ncc!.present(alert, animated: true, completion: nil)
    }
    
    //ham hien thi canh bao
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        ncc?.present(alert, animated: true, completion: nil)
    }
}
