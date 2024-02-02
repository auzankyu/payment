//
//  TransactionViewModel.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import Foundation

class TransactionViewModel {
    
    private let transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    public var bankName: String {
        return transaction.bankName
    }
    
    public var idTransaction: String {
        return transaction.idTransaction
    }
    
    public var merchantName: String {
        return transaction.merchantName
    }
    
    public var totalAmount: Int {
        return transaction.totalAmount
    }
    
    public func payment(completion: @escaping (Bool) -> Void) {
        let lastAmount = UserDefaults.standard.integer(forKey: "amount")
        
        if lastAmount > 0 {
            var lastHistory = UserDefaults.standard.array(forKey: "transactions") as? [Data] ?? []
            
            let newAmount = lastAmount - transaction.totalAmount
            UserDefaults.standard.setValue(newAmount, forKey: "amount")
            
            let newTransaction: HistoryTransaction = .init(
                merchantName: transaction.merchantName,
                nominal: transaction.totalAmount
            )
            
            if let encodedData = try? JSONEncoder().encode(newTransaction) {
                lastHistory.append(encodedData)
                print("[TransactionViewModel] newHistory data :", lastHistory)

                UserDefaults.standard.set(lastHistory, forKey: "transactions")
            } else {
                print("Error encoding data")
            }
            completion(true)
            
        } else {
            completion(false)
        }
    }
}
