//
//  QRCodeAppsTests.swift
//  QRCodeAppsTests
//
//  Created by Auzan Lazuardi on 02/02/24.
//

import XCTest
@testable import QRCodeApps
@testable import RxSwift
@testable import RxCocoa

final class QRCodeAppsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPayment() throws {
        let transaction = Transaction(
            bankName: "BNI",
            idTransaction: "ID1234567899",
            merchantName: "MERCHANT MOCK TEST",
            totalAmount: 50000
        )
        
        let vm = TransactionViewModel(transaction: transaction)
        let vc = TransactionViewController(with: vm)
        
        vc.viewModel.payment { isCompleted in
            if isCompleted {
                XCTAssertTrue(isCompleted)
            } else {
                XCTAssertFalse(isCompleted)
            }
        }
    }
    
    func testHomeViewModel() throws {
        let vm = HomeViewModel()
        let bag = DisposeBag()
        
        let isLoading = BehaviorRelay<Bool>(value: false)
        let profile = PublishRelay<Profile>()
        
        profile.subscribe { result in
            XCTAssertEqual(result.name, "Auzan Lazuardi")
            XCTAssertNil("it should not nill")
        }
        .disposed(by: bag)
    
        vm.getProfile()
        
        XCTAssertEqual(isLoading.value, false)
        
    }
    
    func testGetChart() async {
        let client = APIClientManager()
        let endpoint = HomeEndpoint.getChart
        
        do {
            let result = try await client.get(with: endpoint, using: [ChartType].self)
            XCTAssertEqual(result[0].type, "donutChart")
        } catch {
            XCTFail("The request should not fail")
        }
    }
    
    func testGetProfile() async {
        let client = APIClientManager()
        let endpoint = HomeEndpoint.getProfile
        
        do {
            let result = try await client.get(with: endpoint, using: Profile.self)
            XCTAssertEqual(result.name, "Auzan Lazuardi")
        } catch {
            XCTFail("The request should not fail")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
