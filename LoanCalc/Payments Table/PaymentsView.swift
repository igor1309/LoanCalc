//
//  PaymentsView.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct WidthPreference: PreferenceKey {
    static var defaultValue = CGFloat(0)
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
    typealias Value = CGFloat
}

struct PaymentsView: View {
    @EnvironmentObject var userData: UserData
//    @State private var columnWidths: [Int: CGFloat] = [:]
    
    var payments: [Payment] { userData.schedule.payments }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Payment Schedule")
                .font(.headline)
                .padding([.horizontal, .top])
            
        ScrollView(.vertical, showsIndicators: true) {
            ScrollView(.horizontal, showsIndicators: false) {
                    ForEach(payments.indices) { index in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(index + 1).")
    //                                .widthPreference(column: 0)
    //                                .frame(width: self.columnWidths[0], alignment: .leading)
                                .frame(width: 50 , alignment: .trailing)
                                
                                Text(self.payments[index].beginningBalance.formattedGrouped)
    //                                .widthPreference(column: 1)
    //                                .frame(width: self.columnWidths[1], alignment: .leading)
                                .frame(width: 96, alignment: .trailing)

                                Text(self.payments[index].interest.formattedGrouped)
    //                                .widthPreference(column: 2)
    //                                .frame(width: self.columnWidths[2], alignment: .leading)
                                    .foregroundColor(.secondary)
                                .frame(width: 72, alignment: .trailing)

                                Text(self.payments[index].principal.formattedGrouped)
    //                                .widthPreference(column: 3)
    //                                .frame(width: self.columnWidths[3], alignment: .leading)
                                    .foregroundColor(.secondary)
                                .frame(width: 72, alignment: .trailing)

                                Text(self.payments[index].monthlyPayment.formattedGrouped)
    //                                .widthPreference(column: 4)
    //                                .frame(width: self.columnWidths[4], alignment: .leading)
                                .frame(width: 72, alignment: .trailing)

                                Text(self.payments[index].endingBalance.formattedGrouped)
    //                                .widthPreference(column: 5)
    //                                .frame(width: self.columnWidths[5], alignment: .leading)
                                .frame(width: 96, alignment: .trailing)
                                    .padding(.trailing)

                            }
                            .font(.system(.caption, design: .monospaced))
                            
                            if (index + 1).isMultiple(of: 10) {
                                Divider()
                            }
                        }
                    }
    //                .onPreferenceChange(WidthPreference.self) { self.columnWidths = $0 }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView()
            .environmentObject(UserData())
    }
}
