//
//  ListHoaDonTableViewCell.swift
//  Quan Ly Ban Hang Vat Lieu Xay
//
//  Copyright © 2023 DoAnIOS. All rights reserved.
//

import UIKit

class ListHoaDonTableViewCell: UITableViewCell {
    @IBOutlet weak var lbKH: UILabel!
    @IBOutlet weak var lbTien: UILabel!
    @IBOutlet weak var lbNgay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
