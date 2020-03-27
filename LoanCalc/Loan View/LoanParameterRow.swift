//
//  LoanParameterRow.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LoanParameterRow: View {
    @Binding var amount: Double
    var name: String
    var isPercentage = false
    
    var body: some View {
        HStack {
            Button(action: amountMinus) {
                Image(systemName: "minus")
                    .imageScale(.small)
                    .foregroundColor(.secondary)
                    .frame(width: 44, height: 44)
            }
            
            VStack {
                Text("\(isPercentage ? amount.formattedPercentageWithDecimals : amount.formattedGrouped)")
                    .font(.largeTitle)
                
                Text(name.uppercased())
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: amountPlus) {
                Image(systemName: "plus")
                    .imageScale(.small)
                    .foregroundColor(.secondary)
                    .frame(width: 44, height: 44)
            }
        }
    }
    private func amountPlus() {
        //  MARK: FINISH THIS
        //
    }
    
    private func amountMinus() {
        //  MARK: FINISH THIS
        //
    }
}

struct LoanParameterRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoanParameterRow(amount: .constant(0.077), name: "годовая ставка", isPercentage: true)
            LoanParameterRow(amount: .constant(10_000_000), name: "сумма кредита")
        }
    }
}
