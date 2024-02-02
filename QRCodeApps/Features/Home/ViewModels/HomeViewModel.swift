//
//  HomeViewModel.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    @Injectable var repository: HomeRepositoryProtocol
    
    var profile = PublishRelay<Profile>()
    var lineChart = PublishRelay<ChartType>()
    var pieChart = PublishRelay<ChartType>()
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    public func getProfile() {
        isLoading.accept(true)
        
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let result = try await repository.getUserProfile()
            let amount = UserDefaults.standard.integer(forKey: "amount")
            
            let resultChart = try await repository.getChart()
            
            for chart in resultChart {
                if chart.type == "donutChart" {
                    pieChart.accept(chart)
                } else {
                    lineChart.accept(chart)
                }
            }

            if amount == 0 {
                UserDefaults.standard.setValue(result.amount, forKey: "amount")
            }
            
            profile.accept(result)
            isLoading.accept(false)
        }
    }
    
    public func payment(amount: Int) -> Bool {
        let lastAmount = UserDefaults.standard.integer(forKey: "amount")
        isLoading.accept(true)
        
        if lastAmount > 0 {
            isLoading.accept(false)
            let newAmount = lastAmount - amount
            UserDefaults.standard.setValue(newAmount, forKey: "amount")
            return true
        }
        isLoading.accept(false)
        return false
    }
    
    public func routeToQRScreen(from viewController: UIViewController) {
        HomeRouter.shared.routeToScanner(viewController: viewController)
    }
    
    public func routeToTransaction(from viewController: UIViewController, with viewModel: TransactionViewModel) {
        QRCodeRouter.shared.routeToTransaction(viewController: viewController, with: viewModel)
    }
}
