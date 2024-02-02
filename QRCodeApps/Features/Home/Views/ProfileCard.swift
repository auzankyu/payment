//
//  ProfileCard.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import UIKit

class ProfileCard: UIView {

    private lazy var cardView = CardView(frame: bounds)
    
    private lazy var totalAmounText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.text = "Total saldo:"
        label.textColor = .white
        return label
    }()
    
    private lazy var amounText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var imageTrailing: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "homekit")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .systemBackground
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        clipsToBounds = true
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(amount: Int) {
        let amountFormatted = UtilsManager.shared.formatNumber(value: amount)
        amounText.text = "Rp \(amountFormatted)"
    }

    private func setupConstraint() {
        cardView.backgroundColor = UIColor.fromHex(hex: "#130f40")
        
        addSubview(cardView)
        cardView.addSubview(totalAmounText)
        cardView.addSubview(amounText)
        cardView.addSubview(imageTrailing)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leftAnchor.constraint(equalTo: leftAnchor),
            cardView.rightAnchor.constraint(equalTo: rightAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            totalAmounText.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            totalAmounText.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 16),
            
            amounText.topAnchor.constraint(equalTo: totalAmounText.bottomAnchor),
            amounText.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 16),
            amounText.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -16),
            
            imageTrailing.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: 62),
            imageTrailing.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            imageTrailing.widthAnchor.constraint(equalToConstant: 250),
            imageTrailing.heightAnchor.constraint(equalToConstant: 250),
        ])
    }

}
