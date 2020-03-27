//
//  Loan.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

struct Loan: Identifiable, Codable {
    
    mutating func increase(param: LoanParameter) {
        switch param {
        case .principal:
            //  MARK: FINISH THIS
            //
            principal *= 1.1
        case .rate:
            //  MARK: FINISH THIS
            //  ПРОВЕРКА НА БОЛЬШИЕ ЗНАЧЕНИЯ
            rate += 5 / 100 / 100
        case .term:
            //  MARK: FINISH THIS
            //  ПРОВЕРКА НА ОТРИЦАТЕЛЬНЫЕ ЗНАЧЕНИЯ
            term += 1
        }
    }
    
    mutating func decrease(param: LoanParameter) {
        switch param {
        case .principal:
            //  MARK: FINISH THIS
            //
            principal *= 0.9
        case .rate:
            //  MARK: FINISH THIS
            //  ПРОВЕРКА НА БОЛЬШИЕ ЗНАЧЕНИЯ
            rate -= 5 / 100 / 100
        case .term:
            //  MARK: FINISH THIS
            //  ПРОВЕРКА НА ОТРИЦАТЕЛЬНЫЕ ЗНАЧЕНИЯ
            term -= 1
        }
    }

    
    
    
    var id = UUID()
    
    enum LoanParameter: String, Codable, CaseIterable {
        case principal, rate, term
    }
    
    enum InterestType: String, Codable, CaseIterable {
        case fixedFlat          = "Fixed"       //  в конце срока
        case decliningBalance   = "Annuity"     //  аннуитет
        
        var id: String { rawValue }
    }
    /// тип начисления процентов
    var type: InterestType
    
    var principalStr: String { principal.formattedGrouped }
    var rateStr: String { rate.formattedPercentageWithDecimals }
    var termStr: String { term.formattedGrouped }
    /// срок кредита в годах
    var termInYearsStr: String { (term / 12).formattedGroupedWith1Decimal }
    var monthlyPaymentStr: String { monthlyPayment.formattedGrouped }
    var totalInterestStr: String { totalInterest.formattedGrouped }
    var totalPaymentsStr: String { totalPayments.formattedGrouped }
    
    init(principal: Double, rate: Double, term: Double, type: Loan.InterestType) {
        self.principal = principal
        self.rate = rate
        self.term = term
        self.type = type
    }
    
    private let maxPrincipal = pow(10.0, 10.0)
    private let minPrincipal = 10_000.0
    
    /// сумма кредита
    private var principal: Double {
        didSet {
            /// контроль границ диапазона суммы кредита
            if principal > maxPrincipal {
                principal = maxPrincipal
                print("перебор")
            } else if principal < minPrincipal {
                principal = minPrincipal
                print("маловато")
            }
        }
    }
    
    /// годовая процентная ставка
    private var rate: Double
    
    /// срок кредита в месяцах
    private var term: Double
    
    /// размер ежемесячного платежа
    private var monthlyPayment: Double {
        let r = rate / 100 / 12    // monthly interest rate
        
        switch type {
        case .decliningBalance:
            //  аннуитет http://financeformulas.net/Annuity_Payment_Formula.html
            let p = pow(1 + r, 0 - term)
            return principal / ((1 - p) / r)
        case .fixedFlat:
            return principal * r
        }
    }
    
    /// проценты за весь срок кредита
    private var totalInterest: Double {
        let r = rate / 100 / 12    // monthly interest rate
        
        switch type {
        case .decliningBalance:
            let p = pow(1 + r, 0 - term)
            let mp = principal / ((1 - p) / r)
            return mp * term - principal
        case .fixedFlat:
            return principal * r * term
        }
    }
    
    /// общий размер всех платежей, тело + проценты
    private var totalPayments: Double {
        let r = rate / 100 / 12    // monthly interest rate
        
        switch type {
        case .decliningBalance:
            let p = pow(1 + r, 0 - term)
            let mp = principal / ((1 - p) / r)
            return mp * term
        case .fixedFlat:
            return principal * (1 + r * term)
        }
    }
}
