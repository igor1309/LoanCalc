//
//  LoanParameterRow.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct LoanParamEditor: View {
    var param: Loan.LoanParameter
    
    var body: some View {
        Text("editor for \(param.rawValue)")
    }
}

struct LoanParameterRow: View {
    @EnvironmentObject var userData: UserData
    
    var amountStr: String
    var name: String
    var param: Loan.LoanParameter
    
    @State private var showEditor = false
    
    var body: some View {
        HStack {
            Button(action: amountMinus) {
                Image(systemName: "minus")
                    .imageScale(.small)
                    .foregroundColor(.secondary)
                    .frame(width: 44, height: 44)
            }
            
            VStack {
                Text(amountStr)
                    .font(.largeTitle)
                
                Text(name.uppercased())
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .onLongPressGesture {
                self.showEditor = true
            }
            .sheet(isPresented: $showEditor) {
                LoanParamEditor(param: self.param)
                    .environmentObject(self.userData)
            }
            
            Button(action: amountPlus) {
                Image(systemName: "plus")
                    .imageScale(.small)
                    .foregroundColor(.secondary)
                    .frame(width: 44, height: 44)
            }
        }
    }
    private func amountPlus() {
        userData.loan.increase(param: param)
    }
    
    private func amountMinus() {
        userData.loan.decrease(param: param)
    }
}

struct LoanParameterRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoanParameterRow(amountStr: (0.077).formattedPercentageWithDecimals, name: "годовая ставка", param: .rate)
            LoanParameterRow(amountStr: 10_000_000.formattedGrouped, name: "сумма кредита", param: .principal)
        }
        .environmentObject(UserData())
    }
}
