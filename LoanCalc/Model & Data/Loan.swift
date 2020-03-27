//
//  Loan.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

struct Loan: Identifiable, Codable {
    var id = UUID()
    
    enum InterestType: String, Codable, CaseIterable {
        case fixedFlat          = "Fixed"       //  в конце срока
        case decliningBalance   = "Annuity"     //  аннуитет
        
        var id: String { rawValue }
    }
    
    private let maxPrincipal = pow(10.0, 10.0)
    private let minPrincipal = 10_000.0
    
    /// сумма кредита
    var principal: Double {
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
    var rate: Double
    
    /// срок кредита в месяцах
    var term: Double
    
    /// срок кредита в годах
    var termInYears: Double { term / 12}
}
