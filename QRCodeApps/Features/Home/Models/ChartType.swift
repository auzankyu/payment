//
//  Chart.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 01/02/24.
//

import Foundation


struct ChartType: Codable {
    let type: String
    let data: [ChartDataAll]
    
    struct ChartDataAll: Codable {
        let label: String?
        let percentage: String?
        let month: [Int]?
        let data: [DonutChartData]?
    }
}

struct DonutChartData: Codable {
    let trxDate: String
    let nominal: Int

    enum CodingKeys: String, CodingKey {
        case trxDate = "trx_date"
        case nominal
    }
}
