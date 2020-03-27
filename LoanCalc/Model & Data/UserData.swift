//
//  UserData.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation
import  SwiftPI



final class UserData: ObservableObject {
    
    @Published var loan: Loan = loadLoan() {
        didSet { saveJSONToDocDir(data: loan, filename: "loan.json") }
    }
    
    @Published var loans: [Loan] = loadLoans() {
        didSet { saveJSONToDocDir(data: loans, filename: "loans.json") }
    }
    
    @Published var selectedTab: Int = UserDefaults.standard.integer(forKey: "selectedTab") {
        didSet { UserDefaults.standard.set(selectedTab, forKey: "selectedTab") }
    }
    
    var schedule: Schedule { Schedule(for: loan) }
}

func loadLoan() -> Loan {
    guard let loan: Loan = loadJSONFromDocDir("loan.json") else {
        return Loan(principal: 6_000_000, rate: 7.75, term: 24, type: .decliningBalance)
    }
    return loan
}

func loadLoans() -> [Loan] {
    guard let loans: [Loan] = loadJSONFromDocDir("loans.json") else {
        return sampleLoans//[]
    }
    return loans
}

let sampleLoans: [Loan] = [
    Loan(principal: 26_000_000, rate: 8.25, term: 240, type: .decliningBalance),
    Loan(principal: 26_000_000, rate: 8.25, term: 24, type: .decliningBalance),
    Loan(principal: 6_000_000, rate: 7.75, term: 240, type: .decliningBalance),
    Loan(principal: 6_000_000, rate: 7.75, term: 24, type: .decliningBalance)
]
