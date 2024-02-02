//
//  HistoryTableViewCell.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    static let identifier = "HistoryTableViewCell"
    
    private let container = UIView()
    
    private lazy var mercantName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private lazy var totalAmount: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fromHex(hex: "#2ecc71")
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        mercantName.text = nil
        totalAmount.text = nil
    }
    
    func configure(name: String, amount: Int) {
        mercantName.text = name
        totalAmount.text = "- Rp \(amount)"
    }
    
    private func setupConstraint() {
        container.translatesAutoresizingMaskIntoConstraints = false
//        container.backgroundColor = .yellow
        contentView.addSubview(container)
        
        container.addSubview(mercantName)
        container.addSubview(totalAmount)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            mercantName.topAnchor.constraint(equalTo: container.topAnchor),
            mercantName.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 16),
            mercantName.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            totalAmount.topAnchor.constraint(equalTo: container.topAnchor),
            totalAmount.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16),
            totalAmount.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
}
