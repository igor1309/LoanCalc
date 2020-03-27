//
//  BarChartView.swift
//  LoanCalc
//
//  Created by Igor Malyarov on 27.03.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI
import SwiftPI

struct BarChartView: View {
    @EnvironmentObject var userData: UserData
    @State private var selectedPayment: Int? = nil
    
    var payments: [Payment] { userData.schedule.payments }
    
    var body: some View {
        let max = payments.map { $0.monthlyPayment }.max() ?? 1
        let steps = CGFloat(payments.count + 0) * 2
        
        return HStack {
            if payments.isNotEmpty {
                GeometryReader { geo in
                    ZStack(alignment: .top) {
                        Text(self.selectedPayment == nil ? " " : "month #\(self.selectedPayment!.formattedGrouped)")
                        
                        HStack {
                            ForEach(self.payments.indices) { index in
                                VStack(spacing: 0) {
                                    Rectangle()
//                                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                                        .fill(Color.blue)
                                        .frame(width: geo.size.width / steps,
                                            height: geo.size.height * CGFloat(self.payments[index].interest / max))
                                    
                                            Rectangle()
//                                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                                        .fill(Color.systemTeal)
                                        .frame(width: geo.size.width / steps,
                                            height: geo.size.height * CGFloat(self.payments[index].principal / max))
                                }
                                .onTapGesture {
                                    self.selectedPayment = index + 1
                                }
                            }
                        }
                    }
                }
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
        }
//        .padding()
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
            .padding()
            .environmentObject(UserData())
    }
}
