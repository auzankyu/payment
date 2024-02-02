//
//  HomeViewController.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    
    let viewModel = HomeViewModel()
    let bag = DisposeBag()
    
    private let container = HomeView()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupLayout()
        setupBinding()
        buttonCallback()
        
        container.detailTrxHandler = { [weak self] result in
            let vc = DetailTransactionViewController()
            let viewModel = DetailTransactionViewModel()

            vc.viewModel = viewModel
            vc.viewModel?.detailTrx.accept(result)
            self?.present(vc, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[HomeViewController] viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let amount = UserDefaults.standard.integer(forKey: "amount")
        self.container.configure(amount: amount)
        print("[HomeViewController] viewWillAppear total amount: ", amount)
    }
    
    private func buttonCallback() {
        container.paymentHandler = { [weak self] in
            
            #if targetEnvironment(simulator)
            let code = "BNI.ID1234567899.MERCHANT TOKOPEDIA.100000"
            let vmDebug = QRCodeViewModel()

            vmDebug.dataProcced(with: code) { result in
                let transactionVM = TransactionViewModel(transaction: result)
                self?.viewModel.routeToTransaction(from: self!, with: transactionVM)
            }
                
            #else
            self?.viewModel.routeToQRScreen(from: self!)
            #endif
        }
    }
    
    private func setupBinding() {
        viewModel.profile
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                let amount = UserDefaults.standard.integer(forKey: "amount")
                self?.container.configure(name: result.name, amount: amount)
            }
            .disposed(by: bag)
        
        viewModel.lineChart
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] chart in
                self?.container.configure(lineChart: chart)
            }
            .disposed(by: bag)
        
        viewModel.pieChart
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] chart in
                self?.container.configure(pieChart: chart)
            }
            .disposed(by: bag)
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] loading in
                if loading {
                    self?.container.isHidden = true
                } else {
                    self?.container.isHidden = false
                }
            }
            .disposed(by: bag)
        
        viewModel.isLoading
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: bag)

        viewModel.getProfile()
    }
    
    private func setupLayout() {        
        view.addSubview(loadingIndicator)
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
