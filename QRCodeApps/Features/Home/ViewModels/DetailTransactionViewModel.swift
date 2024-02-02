//
//  DetailTransactionViewModel.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 01/02/24.
//

import Foundation
import RxCocoa

class DetailTransactionViewModel {
    
    let detailTrx = BehaviorRelay<[DonutChartData]>(value: [])
    
    init() {
        
    }
}
