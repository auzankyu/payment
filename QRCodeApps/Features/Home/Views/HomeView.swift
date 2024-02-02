//
//  HomeView.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import UIKit
import Charts
import DGCharts
import RxSwift

protocol ChartDetailDelegate: AnyObject {
    func didTapChart()
}

class HomeView: UIView {

    var paymentHandler: (() -> Void)?
    var detailTrxHandler: (([DonutChartData]) -> Void)?
    weak var delegate: ChartDetailDelegate?
        
    private lazy var userProfileTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let cardProfile = ProfileCard()
    
    private lazy var lineChartView: LineChartView = {
        let view = LineChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pieChartView: PieChartView = {
        let view = PieChartView ()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var qrButton: CButton = {
        let button = CButton()
        button.setTitle("Pay with QR", for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(didTapPayment), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        setupLayout()
        pieChartView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(name: String, amount: Int) {
        userProfileTitle.text = "Hi, \(name)"
        cardProfile.configure(amount: amount)
    }
    
    func configure(amount: Int) {
        cardProfile.configure(amount: amount)
    }
    
    func configure(name: String) {
        userProfileTitle.text = "Hi, \(name)"
    }
    
    func configure(lineChart: ChartType) {
        setupLineChart(with: lineChart)
    }
    
    func configure(pieChart: ChartType) {
        setuPieChart(with: pieChart)
    }
    
    @objc func didTapPayment() {
        paymentHandler?()
    }
    
    private func setupLayout() {
        addSubview(userProfileTitle)
        addSubview(cardProfile)
        addSubview(lineChartView)
        addSubview(pieChartView)
        addSubview(qrButton)
        
        NSLayoutConstraint.activate([
            
            userProfileTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userProfileTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            cardProfile.topAnchor.constraint(equalTo: userProfileTitle.bottomAnchor, constant: 24),
            cardProfile.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            cardProfile.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            cardProfile.heightAnchor.constraint(equalToConstant: 100),
            
            lineChartView.topAnchor.constraint(equalTo: cardProfile.bottomAnchor, constant: 16),
            lineChartView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            lineChartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            lineChartView.heightAnchor.constraint(equalToConstant: 150),
            
            pieChartView.topAnchor.constraint(equalTo: lineChartView.bottomAnchor, constant: 16),
            pieChartView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            pieChartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            pieChartView.bottomAnchor.constraint(equalTo: qrButton.topAnchor, constant: -16),
            
            qrButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            qrButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            qrButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            qrButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setupLineChart(with dataEntryChart: ChartType) {
        guard let dataEntry = dataEntryChart.data[0].month else { return }
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<dataEntry.count {
            let value = ChartDataEntry(x: Double(i), y: Double(dataEntry[i]))
            
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Months")
        line1.colors = [NSUIColor.blue]
        
        let dataToChart = LineChartData(dataSet: line1)
        
        lineChartView.data = dataToChart
        lineChartView.chartDescription.text = "Line Chart"
    }
    
    func setuPieChart(with dataEntryChart: ChartType) {
        let dataEntry = dataEntryChart.data
        var pieChartEntry = [ChartDataEntry]()

        for i in 0..<dataEntry.count {
            let value = PieChartDataEntry(
                value: Double(dataEntry[i].percentage!)!,
                label: dataEntry[i].label,
                data: dataEntry[i]
            )
            pieChartEntry.append(value)
        }

        let pie1 = PieChartDataSet(entries: pieChartEntry, label: "")
        pie1.colors = [UIColor.red, UIColor.green, UIColor.purple, UIColor.blue]
        
        let dataToChart = PieChartData(dataSet: pie1)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        dataToChart.dataSet?.valueFormatter = DefaultValueFormatter(formatter: pFormatter)
        
        pieChartView.drawEntryLabelsEnabled = false
        pieChartView.data = dataToChart
    }
}

extension HomeView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

        guard let data = entry.data as? ChartType.ChartDataAll else { return }
        
        detailTrxHandler?(data.data!)
        
    }
}
