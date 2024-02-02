//
//  HistoryViewController.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController {

    var viewModel = HistoryViewModel()
    let bag = DisposeBag()
    
    private lazy var emptyLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.isHidden = true
        label.text = "Belum ada transaksi berlangsung"
        return label
    }()
    
    private lazy var historyTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupConstraint()
        
        viewModel.transactions.bind(to: historyTableView.rx.items(cellIdentifier: HistoryTableViewCell.identifier, cellType: HistoryTableViewCell.self)) { row, history, cell in
            
            cell.configure(name: history.merchantName, amount: history.nominal)
        }
        .disposed(by: bag)
        
        historyTableView.rx.setDelegate(self)
            .disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getAllTransaction { [weak self] isEmpty in
            if isEmpty {
                print("[HistoryViewController] Transaksi tidak ada")
                self?.historyTableView.isHidden = true
                self?.emptyLabel.isHidden = false
            } else {
                print("[HistoryViewController] Ada Transaksi")
                self?.historyTableView.isHidden = false
                self?.emptyLabel.isHidden = true
                
            }
        }
    }
    
    private func setupConstraint() {
        view.addSubview(emptyLabel)
        view.addSubview(historyTableView)
        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            historyTableView.topAnchor.constraint(equalTo: view.topAnchor),
            historyTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            historyTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
