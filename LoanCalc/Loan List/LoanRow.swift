//
//  LoanRow.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct LoanRow: View {
    var loan: Loan
    
    var body: some View {
        HStack {
            Image(systemName: "doc.plaintext")
                .padding(.trailing)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(loan.principalStr)
                    Spacer()
                    Text(loan.rateStr)
                        .font(.subheadline)
                }
                .foregroundColor(.systemOrange)
                
                HStack {
                    Text(loan.type.id)
                    Spacer()
                    Text(loan.termStr + " мес.")
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
            }
        }
        .contentShape(Rectangle())
    }
}

struct LoanRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LoanRow(loan: sampleLoans[0])
            LoanRow(loan: sampleLoans[1])
        }
    }
}
