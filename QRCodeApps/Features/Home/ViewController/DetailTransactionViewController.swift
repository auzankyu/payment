//
//  DetailTransactionViewController.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 01/02/24.
//

import UIKit
import RxSwift

class DetailTransactionViewController: UIViewController, UITableViewDelegate {

    var viewModel: DetailTransactionViewModel?
    let bag = DisposeBag()
    
    @IBOutlet weak var detailTrxTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "DetailTransactionTableViewCell", bundle: nil)
        detailTrxTableView.register(nib, forCellReuseIdentifier: DetailTransactionTableViewCell.identifier)
        
        
        viewModel?.detailTrx.bind(to: detailTrxTableView.rx.items(cellIdentifier: DetailTransactionTableViewCell.identifier, cellType: DetailTransactionTableViewCell.self)) { row, item, cell in

            cell.configure(trx: item.trxDate, nominaltxt: item.nominal)
        }
        .disposed(by: bag)
        
        detailTrxTableView.rx.setDelegate(self)
            .disposed(by: bag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
