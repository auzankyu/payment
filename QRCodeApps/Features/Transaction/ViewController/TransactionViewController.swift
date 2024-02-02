//
//  TransactionViewController.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import UIKit

class TransactionViewController: UIViewController {

    var viewModel: TransactionViewModel
    
    lazy var bankNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "Nama Bank:"
        return label
    }()
    
    lazy var bankNameText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .label
        return label
    }()
    
    lazy var idTransactionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "ID Transaksi:"
        return label
    }()
    lazy var idTransactionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .label
        return label
    }()
    
    lazy var merchantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "Nama Merchant: "
        return label
    }()
    
    lazy var merchantText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .label
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.text = "Total Pembayaran:"
        return label
    }()
    
    lazy var amountText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .label
        return label
    }()
    
    lazy var payButton: CButton = {
        let button = CButton()
        button.setTitle("Lakukan Pembayaran", for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(didTapPay), for: .touchUpInside)
        return button
    }()
    
    
    init(with viewModel: TransactionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupLayout()
        setupConstraint()
    }
    
    @objc func didTapPay() {
        viewModel.payment { [weak self] isCompleted in
            if isCompleted {
                let alert = UIAlertController(
                    title: "Success",
                    message: "Berhasil melakukan transaksi",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    self?.navigationController?.popToRootViewController(animated: true)
                })
                self?.present(alert, animated: true)
            } else {
                let alert = UIAlertController(
                    title: "Oops",
                    message: "Saldo anda tidak mencukupi",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    self?.navigationController?.popToRootViewController(animated: true)
                })
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func setupLayout() {
        bankNameText.text = viewModel.bankName
        idTransactionText.text = viewModel.idTransaction
        merchantText.text = viewModel.merchantName
        amountText.text = "\(viewModel.totalAmount)"
    }
    
    private func setupConstraint() {
        view.addSubview(bankNameLabel)
        view.addSubview(bankNameText)
        view.addSubview(idTransactionLabel)
        view.addSubview(idTransactionText)
        view.addSubview(merchantLabel)
        view.addSubview(merchantText)
        view.addSubview(amountLabel)
        view.addSubview(amountText)
        view.addSubview(payButton)
        
        NSLayoutConstraint.activate([
            bankNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            bankNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            bankNameText.topAnchor.constraint(equalTo: bankNameLabel.bottomAnchor, constant: 4),
            bankNameText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            
            idTransactionLabel.topAnchor.constraint(equalTo: bankNameText.bottomAnchor, constant: 16),
            idTransactionLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            idTransactionText.topAnchor.constraint(equalTo: idTransactionLabel.bottomAnchor, constant: 4),
            idTransactionText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            
            merchantLabel.topAnchor.constraint(equalTo: idTransactionText.bottomAnchor, constant: 16),
            merchantLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            merchantText.topAnchor.constraint(equalTo: merchantLabel.bottomAnchor, constant: 4),
            merchantText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            
            amountLabel.topAnchor.constraint(equalTo: merchantText.bottomAnchor, constant: 16),
            amountLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            amountText.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4),
            amountText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
            
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            payButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            payButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            payButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

}
