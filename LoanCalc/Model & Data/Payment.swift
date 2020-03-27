//
//  Payment.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import Foundation

struct Payment: Identifiable, Hashable {
    var id = UUID()
    
    var beginningBalance = Double(0)
    var interest = Double(0)
    var principal = Double(0)
    var monthlyPayment = Double(0)
    var endingBalance = Double(0)
}
