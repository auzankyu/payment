//
//  DetailTransactionTableViewCell.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 01/02/24.
//

import UIKit

class DetailTransactionTableViewCell: UITableViewCell {

    static let identifier = "DetailTransactionTableViewCell"
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var trxDate: UILabel!
    @IBOutlet weak var nominalTrx: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(trx: String, nominaltxt: Int) {
        let formatted = UtilsManager.shared.formatNumber(value: nominaltxt)
        trxDate.text = trx
        nominalTrx.text = "Rp \(formatted)"
    }
    
    override func prepareForReuse() {
        trxDate.text = nil
        nominalTrx.text = nil
    }
}
