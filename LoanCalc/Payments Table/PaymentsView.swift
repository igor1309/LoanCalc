//
//  PaymentsView.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct WidthPreference: PreferenceKey {
    typealias Value = [Int: CGFloat]
    
    static let defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

extension View {
    func widthPreference(column: Int) -> some View {
        background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: WidthPreference.self,
                                value: [column: geo.size.width])
        })
    }
}


struct PaymentsView: View {
    @EnvironmentObject var userData: UserData
    @State private var columnWidths: [Int: CGFloat] = [:]
    
    var payments: [Payment] { userData.schedule.payments }
    
    private func paymentRow(index: Int) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Group {
                Text("\(index + 1).")
                    .widthPreference(column: 0)
                    .frame(width: self.columnWidths[0], alignment: .trailing)
//                    .frame(width: 50 , alignment: .trailing)
                
                Text(self.payments[index].beginningBalance.formattedGrouped)
                    .widthPreference(column: 1)
                    .frame(width: self.columnWidths[1], alignment: .trailing)
//                    .frame(width: 96, alignment: .trailing)
                
                Text(self.payments[index].interest.formattedGrouped)
                    .widthPreference(column: 2)
                    .frame(width: self.columnWidths[2], alignment: .trailing)
                    .foregroundColor(.secondary)
//                    .frame(width: 72, alignment: .trailing)
                
                Text(self.payments[index].principal.formattedGrouped)
                    .widthPreference(column: 3)
                    .frame(width: self.columnWidths[3], alignment: .trailing)
                    .foregroundColor(.secondary)
//                    .frame(width: 72, alignment: .trailing)
                
                Text(self.payments[index].monthlyPayment.formattedGrouped)
                    .widthPreference(column: 4)
                    .frame(width: self.columnWidths[4], alignment: .trailing)
//                    .frame(width: 72, alignment: .trailing)
                
                Text(self.payments[index].endingBalance.formattedGrouped)
                    .widthPreference(column: 5)
                    .frame(width: self.columnWidths[5], alignment: .trailing)
//                    .frame(width: 96, alignment: .trailing)
                    .padding(.trailing)
                }
                .font(.system(.caption, design: .monospaced))
                .padding(.leading)
            }
            
            if (index + 1).isMultiple(of: 10) {
                Divider()
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Payment Schedule")
                .font(.headline)
                .padding([.horizontal, .top])
            
            ScrollView(.vertical, showsIndicators: true) {
                ScrollView(.horizontal, showsIndicators: false) {
                    ForEach(payments.indices) { index in
                        
                        self.paymentRow(index: index)
                            
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .onPreferenceChange(WidthPreference.self) { self.columnWidths = $0 }
        }
    }
}

struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView()
            .environmentObject(UserData())
    }
}
